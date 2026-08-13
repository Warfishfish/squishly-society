-- ===========================================================
-- Migration 011 — everyday price cuts
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- WHY THESE TEN AND NOT EVERYTHING
-- The catalogue is really two businesses. Keychains, mochi and the
-- small prism land at $1.42-$6.63 and earn 64-84% margin. The giants,
-- dumplings and boxes land at $12-$30 and earn 45-52%.
--
-- Australian shops sell squishies at $6.95-$13.95, averaging $9.62.
-- The mochi line was sitting ABOVE that entire range, which is the
-- actual competitiveness problem. The giants have no physical-store
-- equivalent to be price-checked against, and no margin to give away,
-- so they are left alone.
--
-- A flat 20% cut across everything would have pushed 17 of 35
-- products under 40% margin. This does the opposite: it cuts hardest
-- exactly where there is room, and nowhere else.
--
-- Every product below stays above 52% margin after the cut.
--
-- Safe to re-run.
-- ===========================================================

begin;

-- ---------- Keychains: the impulse-buy tier ----------
-- These land at $1.42-$2.12, so even at these prices they earn more
-- than most of the catalogue. Pricing them at $8.95 was leaving the
-- pocket-money buyer to the shops.
update products set price = 4.95 where sku = 'sq-011';  -- was 5.95 → 57.2%
update products set price = 6.95 where sku = 'sq-013';  -- was 8.95 → 79.6%
update products set price = 6.95 where sku = 'sq-015';  -- was 8.95 → 79.6%
update products set price = 5.95 where sku = 'sq-016';  -- was 7.95 → 76.1%
update products set price = 5.95 where sku = 'sq-018';  -- was 7.95 → 66.2%

-- ---------- Mochi: the line being price-checked ----------
-- This is the range an Australian shopper compares directly against a
-- shop shelf. All four now sit inside the $6.95-$13.95 local bracket.
update products set price = 11.95 where sku = 'sq-020'; -- was 14.95 → 57.7%
update products set price = 12.95 where sku = 'sq-021'; -- was 15.95 → 59.2%
update products set price = 13.95 where sku = 'sq-022'; -- was 17.95 → 57.3%
update products set price = 13.95 where sku = 'sq-019'; -- was 18.95 → 52.5%

-- ---------- Prism: the entry point to that category ----------
-- Leaves room above it for sq-063 at $21.95 and sq-070 at $39.95, so
-- the category still reads good / better / best.
update products set price = 13.95 where sku = 'sq-069'; -- was 16.95 → 56.6%

commit;


-- ===========================================================
-- CHECK IT WORKED — every margin should be 52% or better
-- ===========================================================
--   select sku, name, price,
--          round(supplier_cost + coalesce(shipping_cost,0), 2) as landed,
--          round((price - supplier_cost - coalesce(shipping_cost,0)) / price * 100, 1) as margin
--   from products
--   where sku in ('sq-011','sq-013','sq-015','sq-016','sq-018',
--                 'sq-019','sq-020','sq-021','sq-022','sq-069')
--   order by price;
-- ===========================================================


-- ===========================================================
-- DELIBERATELY NOT CUT — and why
-- ===========================================================
-- sq-001 Coconut Mochi ($18.95) is the awkward one. It is priced
--   above the Australian range like the rest of the mochi line, but
--   it lands at $10.25 and already earns only 45.9%. Cutting it to
--   $13.95 would leave 26%. It needs a cheaper supplier, not a lower
--   price. Worth re-sourcing.
--
-- sq-002 Glow Pack is priced per variant, so its prices live in the
--   product_variants table rather than here. Change it on its own
--   page in the admin if you want it moved.
--
-- sq-023 Mochi Mega Pack (50pc, $44.95) is a bulk party item, not
--   something anyone price-checks against a single squishy.
--
-- Everything sq-063 and above is a novelty or oversized item with no
--   local equivalent and 45-52% margin. There is nothing to gain by
--   discounting a product a shop does not stock.
--
-- ONE HONEST CAVEAT
-- With 12-25 day delivery you will not beat a shop someone can walk
-- into today. Matching on price removes an objection; it does not win
-- the sale. What wins it is stocking things they cannot get locally —
-- which is what the giants and dumplings actually are. Consider
-- putting the marketing there and treating this cut as defence.
-- ===========================================================
