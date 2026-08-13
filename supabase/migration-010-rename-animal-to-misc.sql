-- ===========================================================
-- Migration 010 — retire the `animal` category
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- The `animal` category only ever held three products (sq-084,
-- sq-085, sq-086 — a duck, a bear and a goose) and was never a
-- good fit as a standalone shop tile. This folds it into a
-- catch-all `misc` category instead.
--
-- The matching label, tile and filter are updated in products.js
-- and app.js, which is a git push rather than SQL.
--
-- Safe to re-run.
-- ===========================================================

begin;

update products
   set category = 'misc'
 where category = 'animal';

commit;

-- ===========================================================
-- CHECK IT WORKED — expect 0 rows
-- ===========================================================
--   select sku, name, category from products where category = 'animal';
-- ===========================================================
