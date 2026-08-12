-- ===========================================================
-- Migration 002 — variant label
-- ===========================================================
-- Run this ONCE in the Supabase SQL Editor, the same way you ran
-- schema.sql: SQL Editor → New query → paste → Run.
--
-- WHY: the product page needs to know what a product's options are
-- called — "Size" for the prism cube, "Pack size" for the mochi
-- bucket, "Key Count" for the clicker keychain. Without this the
-- shop would just say "Option" for everything.
--
-- Safe to re-run.
-- ===========================================================

alter table products
  add column if not exists variant_label text;

comment on column products.variant_label is
  'What this product''s options are called on the shop, e.g. "Size" or "Colour / style".';

-- ---------- remove the retired prism cube ----------
-- sq-064 (Studio Light Prism Cube) was dropped from the catalogue after
-- the first seed had already been loaded, so it's still sitting in the
-- database. Without this it would reappear on the shop the moment the
-- storefront starts reading from here.
delete from product_variants
  where product_id in (select id from products where sku = 'sq-064');
delete from products where sku = 'sq-064';

-- Backfill the labels the shop is currently using.
update products set variant_label = 'Colour'         where sku = 'sq-001';
update products set variant_label = 'Pack size'      where sku in ('sq-002','sq-011');
update products set variant_label = 'Option'         where sku = 'sq-013';
update products set variant_label = 'Key Count'      where sku = 'sq-018';
update products set variant_label = 'Size'           where sku = 'sq-063';
update products set variant_label = 'Colour / style'
  where sku in ('sq-015','sq-016','sq-019','sq-020','sq-021','sq-022','sq-023');

-- Rebuild the public view so it includes the new column.
-- (A view doesn't pick up new columns on its own, even with select *.)
drop view if exists public_products;
create view public_products as
  select
    p.id,
    p.sku,
    p.name,
    p.category,
    p.description,
    p.price,
    p.image,
    p.gallery,
    p.variant_label,
    p.source_rating,
    p.source_reviews,
    p.source_orders,
    p.source_tags,
    p.source_quotes,
    p.is_mystery,
    p.is_new_drop,
    p.sort_order
  from products p
  where p.status = 'active';

grant select on public_products to anon, authenticated;

-- Check it worked:
--   select sku, variant_label from products order by sku;
