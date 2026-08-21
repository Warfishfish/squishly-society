-- ===========================================================
-- Migration 014 — Giant Dumpling Squishy: add pack sizes
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- WHAT THIS DOES
-- sq-065 "Giant Dumpling Squishy" sold at one price ($34.95) with no
-- options at all, even though its variant_label said "Colour". This
-- gives it three buyable options — single, 2-pack and 3-pack — each
-- with its own price, and relabels the picker to "Pack size".
--
-- WHY PACKS AND NOT SIZES
-- The supplier listing (item 1005012400124481) was checked directly on
-- 21 Aug 2026. It has ONE option group, "Color", offering six colours
-- plus random multipacks of 1–6. There is no size option: the
-- "10cm / 8.5cm / 6.5cm" on the product photo are the dimensions of
-- the single item, not choices. So sizes could not be added honestly;
-- packs are the real pricing tiers the supplier offers.
--
-- COSTS ARE THE REGULAR PRICES, NOT THE "WELCOME DEAL"
-- The listing was showing a new-shopper price of AU$1.41 against a
-- regular price of AU$16.16. Costing from the welcome deal would show
-- a fantasy margin and lose money on every real order. Regular prices
-- used throughout, as everywhere else in this catalogue:
--
--   Random 1 pcs   AU$16.16
--   Random 2 pcs   AU$29.38
--   Random 3 pcs   AU$40.36
--
-- Supplier shipping is free on this listing, so landed cost = item cost.
--
-- THE MARGINS
--   Single   $34.95  − $16.16  = $18.79   53.8%
--   2-pack   $59.95  − $29.38  = $30.57   51.0%
--   3-pack   $84.95  − $40.36  = $44.59   52.5%
--
-- All comfortably above the 50% floor this catalogue holds to, and the
-- customer saves $9.95 on the 2-pack and $19.90 on the 3-pack versus
-- buying singles — a real reason to trade up rather than a fake one.
-- The 3-pack also clears $75, so it earns the 10% discount and free
-- postage automatically.
--
-- Safe to re-run: variants are cleared and rebuilt each time.
-- ===========================================================

begin;

-- The picker is labelled by pack size now, not colour.
update products
   set variant_label = 'Pack size'
 where sku = 'sq-065';

-- Rebuild cleanly so re-running can't double up the options.
delete from product_variants
 where product_id = (select id from products where sku = 'sq-065');

insert into product_variants (product_id, label, variant_cost, price, sort_order)
select p.id, v.label, v.cost, v.price, v.sort_order
  from products p,
       (values
          ('Single',  16.16, 34.95, 1),
          ('2-pack',  29.38, 59.95, 2),
          ('3-pack',  40.36, 84.95, 3)
       ) as v(label, cost, price, sort_order)
 where p.sku = 'sq-065';

-- The headline price is what the cheapest option costs, so the shop
-- card reads "From $34.95" rather than contradicting the picker.
update products
   set price = 34.95
 where sku = 'sq-065';

-- Mention the packs in the description, since the saving is the reason
-- to pick one. Rewritten in full rather than appended, so re-running
-- this migration can't stack the sentence up twice.
update products
   set description =
       'A properly oversized dumpling — 10cm across — that squashes flat and '
    || 'slowly puffs back up, packed in its own little bamboo steamer. The '
    || 'satisfying, filmable one: big enough to fill your hand and the frame. '
    || 'Grab a single, or take the 2-pack or 3-pack and save — colours are '
    || 'picked at random.'
 where sku = 'sq-065';

commit;


-- ===========================================================
-- CHECK IT WORKED
-- ===========================================================
--   select p.sku, p.variant_label, p.price,
--          v.label, v.variant_cost, v.price as sell,
--          round((v.price - v.variant_cost) / v.price * 100, 1) as margin_pct
--     from products p
--     join product_variants v on v.product_id = p.id
--    where p.sku = 'sq-065'
--    order by v.sort_order;
--
-- Expect three rows: Single / 2-pack / 3-pack, margins 53.8 / 51.0 / 52.5.
-- ===========================================================


-- ===========================================================
-- ONE THING TO DECIDE YOURSELF
-- ===========================================================
-- The multipacks ship as RANDOM colours — the supplier picks. The
-- description now says so, which it must: implying a customer chooses
-- the colours when they can't would be misleading under Australian
-- Consumer Law.
--
-- If you would rather sell specific colours, that means ordering each
-- colour separately from the supplier (they're all within 60c of each
-- other, so a single price would still work) and dropping the random
-- packs. That's a stock decision, not a code one.
-- ===========================================================
