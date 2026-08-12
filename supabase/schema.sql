-- ===========================================================
-- Squishy Society — database schema
-- ===========================================================
-- Run this ONCE in the Supabase SQL Editor:
--   Supabase dashboard → SQL Editor → New query → paste → Run
--
-- It is safe to re-run: everything uses "if not exists" or is
-- dropped and recreated first.
--
-- SECURITY MODEL (read this before changing anything)
-- ---------------------------------------------------
-- The `products` and `product_variants` tables are locked to
-- LOGGED-IN USERS ONLY. Anonymous visitors cannot read them at
-- all — not even the product names.
--
-- The public shop reads the `public_products` view instead,
-- which deliberately leaves out supplier_cost, supplier_url and
-- notes. That way our margins and private notes can never leak
-- to a customer poking at the network tab, even by accident.
--
-- This is enforced by the DATABASE, not by the admin pages. Even
-- if someone bypassed the admin UI entirely, they still couldn't
-- read the private columns.
-- ===========================================================


-- ---------- products ----------
-- One table serves store products, drafts, AND product research.
-- The `status` column is what separates them. This keeps things
-- simple and means "promote a research item to a real product"
-- is just a status change, not a data migration.

create table if not exists products (
  id              uuid primary key default gen_random_uuid(),

  -- identity
  sku             text unique not null,          -- "sq-001"
  name            text not null,
  category        text,                          -- mochi | keychain | prism
  description     text,

  -- money (all AUD)
  price           numeric(10,2) default 0,       -- what WE charge
  supplier_cost   numeric(10,2) default 0,       -- what WE pay      [PRIVATE]
  shipping_cost   numeric(10,2) default 0,       -- supplier postage [PRIVATE]

  -- sourcing
  supplier_name   text,
  supplier_url    text,                          --                  [PRIVATE]

  -- images
  image           text,                          -- main photo
  gallery         text[] default '{}',           -- extra photos

  -- what this product's options are called on the shop,
  -- e.g. "Size", "Pack size", "Colour / style"
  variant_label   text,

  -- status
  -- draft       = being worked on, not on the shop
  -- active      = live on the shop
  -- hidden      = temporarily pulled, keeps its data
  -- out_of_stock= visible but not buyable
  -- archived    = retired
  -- research    = a candidate we're evaluating, never on the shop
  status          text not null default 'draft',
  research_status text,                          -- interesting|researching|testing|winner|rejected

  -- supplier listing social proof (shown on the shop, labelled as supplier reviews)
  source_rating   numeric(3,2),
  source_reviews  int,
  source_orders   text,                          -- "2,000+" — free text, matches how listings show it
  source_tags     text[] default '{}',
  source_quotes   jsonb default '[]'::jsonb,     -- [{text, author, variant}]

  -- merchandising flags
  is_mystery      boolean default false,
  is_new_drop     boolean default false,
  sort_order      int default 0,

  -- internal
  notes           text,                          --                  [PRIVATE]

  created_at      timestamptz default now(),
  updated_at      timestamptz default now(),

  constraint products_status_check check (
    status in ('draft','active','hidden','out_of_stock','archived','research')
  ),
  constraint products_research_status_check check (
    research_status is null or
    research_status in ('interesting','researching','testing','winner','rejected')
  )
);

create index if not exists products_status_idx   on products (status);
create index if not exists products_category_idx on products (category);


-- ---------- product_variants ----------
-- Sizes / pack counts that carry their own price.
-- A product with no rows here is simply a single-price product.

create table if not exists product_variants (
  id           uuid primary key default gen_random_uuid(),
  product_id   uuid not null references products(id) on delete cascade,
  label        text not null,                    -- "30mm", "12pcs without box"
  variant_cost numeric(10,2) default 0,          -- what WE pay      [PRIVATE]
  price        numeric(10,2) default 0,          -- what WE charge
  sort_order   int default 0,
  created_at   timestamptz default now()
);

create index if not exists product_variants_product_idx on product_variants (product_id);


-- ---------- settings ----------
-- Simple key/value store. Avoids a wide table we'd keep altering.

create table if not exists settings (
  key        text primary key,
  value      text,
  updated_at timestamptz default now()
);

insert into settings (key, value) values
  ('store_name',  'Squishy Society'),
  ('store_email', ''),
  ('currency',    'AUD'),
  ('country',     'Australia'),
  ('timezone',    'Australia/Melbourne')
on conflict (key) do nothing;


-- ---------- keep updated_at honest ----------

create or replace function touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

drop trigger if exists products_touch_updated_at on products;
create trigger products_touch_updated_at
  before update on products
  for each row execute function touch_updated_at();

drop trigger if exists settings_touch_updated_at on settings;
create trigger settings_touch_updated_at
  before update on settings
  for each row execute function touch_updated_at();


-- ===========================================================
-- ROW LEVEL SECURITY
-- ===========================================================
-- With RLS on and no permissive policy for `anon`, anonymous
-- requests to these tables return nothing at all.

alter table products         enable row level security;
alter table product_variants enable row level security;
alter table settings         enable row level security;

-- Table-level grants.
-- Two independent locks, deliberately. RLS decides which ROWS a
-- role may touch; GRANT decides whether it may touch the table at
-- all. Supabase grants `anon` broad table access by default, so we
-- revoke it explicitly here rather than trusting a default we can't
-- see. If RLS were ever accidentally switched off, this revoke
-- still keeps anonymous visitors out.
revoke all on products         from anon;
revoke all on product_variants from anon;
revoke all on settings         from anon;

grant select, insert, update, delete on products         to authenticated;
grant select, insert, update, delete on product_variants to authenticated;
grant select, insert, update, delete on settings         to authenticated;

-- Logged-in admin can do everything.
drop policy if exists "admin full access" on products;
create policy "admin full access" on products
  for all to authenticated
  using (true) with check (true);

drop policy if exists "admin full access" on product_variants;
create policy "admin full access" on product_variants
  for all to authenticated
  using (true) with check (true);

drop policy if exists "admin full access" on settings;
create policy "admin full access" on settings
  for all to authenticated
  using (true) with check (true);

-- Note: no policy is created for `anon` on purpose.
-- Anonymous visitors get their data from the view below instead.


-- ===========================================================
-- PUBLIC VIEW — what the shop is allowed to see
-- ===========================================================
-- Only active products, and only safe columns.
-- supplier_cost, shipping_cost, supplier_url, notes and
-- research_status are deliberately absent.
--
-- security_invoker = off (the default for views) means this view
-- runs with the view owner's rights, so it can read the locked
-- table on behalf of anonymous visitors — but only ever exposes
-- the columns and rows written below.

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

drop view if exists public_product_variants;
create view public_product_variants as
  select
    v.id,
    v.product_id,
    v.label,
    v.price,          -- our sell price only; variant_cost is NOT exposed
    v.sort_order
  from product_variants v
  join products p on p.id = v.product_id
  where p.status = 'active';

grant select on public_products         to anon, authenticated;
grant select on public_product_variants to anon, authenticated;


-- ===========================================================
-- AFTER RUNNING THIS
-- ===========================================================
-- 1. Authentication → Providers → Email: turn OFF "Enable sign ups"
--    (so nobody but you can ever create an account)
-- 2. Authentication → Users → "Add user" → create your admin login
-- 3. Run the generated seed file to load the existing 14 products
-- ===========================================================
