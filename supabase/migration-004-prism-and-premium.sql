-- ===========================================================
-- Migration 004 — two prism products + premium mystery boxes
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Read from live AliExpress listings on 12 August 2026, using
-- REGULAR prices. Every product clears 48% gross margin.
--
-- Safe to re-run (upserts on sku).
--
-- A NOTE ON THE PRISMS
-- These two are unusual and worth pointing out: their "Welcome
-- deal" price is only ONE CENT below the regular price ($6.04 vs
-- $6.05). Almost every other listing in this research had a 50%
-- gap. That means these are honest, stable prices — what you see
-- is what you'll keep paying. Both also ship free.
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-069 · Classic Light Prism (80mm)             DRAFT
-- -----------------------------------------------------------
-- Landed $6.05 (free shipping) → $16.95 = 64.3% margin.
-- The best margin of anything found in this research.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-069',
  'Classic Light Prism',
  'prism',
  'The iconic triangular prism — hold it to a window and it throws a proper rainbow across the wall. Solid K9 optical glass, 80mm long, and it arrives in a gift box. The one everyone recognises.',
  16.95, 6.05, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005008023975740.html',
  null, '{}', 'Packaging',
  'draft', 4.6, 43, '436',
  '{"well-packaged","good quality","fast delivery","nice playfulness"}',
  true, 9,
  'VERIFIED 12 Aug 2026. Seller China Tools Enterprise Store 95.4% positive with 2,026 followers - the most established seller found in this whole research. FREE shipping, delivery 19-25 Aug. K9 optical glass, 25x25x80mm. No Brand Name field - generic and IP-clean. Real price: welcome deal $6.04 vs regular $6.05, a 1c gap, so no pricing trap here. Two variants: gift box or display stand. 2 of 43 reviews mention a flimsy stand, so the gift-box variant may be the safer one to stock. BEST MARGIN IN THE CATALOGUE at 64%. NEEDS PHOTO before publishing.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  variant_label = excluded.variant_label, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  source_tags = excluded.source_tags, notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-070 · Giant Light Prism (200mm)              DRAFT
-- -----------------------------------------------------------
-- Landed $18.12 (free shipping) → $39.95 = 54.6% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-070',
  'Giant Light Prism',
  'prism',
  'Twenty centimetres of solid optical glass. Big enough to cast a rainbow right across a room, and heavy enough to feel like a proper object rather than a toy. A desk piece as much as a science one.',
  39.95, 18.12, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005010159020535.html',
  null, '{}', null,
  'draft', 4.9, 8, '181',
  '{"clear glass","well packaged"}',
  false, 10,
  'VERIFIED 12 Aug 2026. Same seller family as sq-069. FREE shipping, delivery 19-25 Aug. K9 optical glass, 30x30x200mm, 290g - the weight is a selling point but also means it needs careful packaging. Real price: $18.11 welcome vs $18.12 regular, so a genuine price. No Brand Name - IP-clean. CAUTION: only 8 reviews, so the 4.9 rating is thin evidence, though 181 sold. Pairs naturally with sq-069 as the premium option in a good/better lineup. NEEDS PHOTO before publishing.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-071 · 24-Day Squishy Advent Calendar         DRAFT
-- -----------------------------------------------------------
-- Landed $30.38 (free shipping) → $64.95 = 53.2% margin.
-- The SAFER of the two premium boxes. Recommended over sq-072.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-071',
  '24-Day Squishy Advent Calendar',
  'mystery',
  'Twenty-four doors, twenty-four different squishies, one a day. Built for the countdown to Christmas but honestly good any time you want twenty-four days of small surprises. The gift that keeps unboxing.',
  64.95, 30.38, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005012642006030.html',
  null, '{}', 'Edition',
  'draft', 3.8, 8, '500+',
  '{"good value","fun unboxing"}',
  true, 11,
  'VERIFIED 12 Aug 2026. Seller ZHONGXI Groom And Style 89.5% positive. FREE shipping, delivery 21-28 Aug. 24 individual squishies. No Brand Name - IP-clean. THE SAFER PREMIUM BOX of the two: 500+ sold vs 82 for sq-072, and a better seller rating. BUT rating is only 3.8 and the recurring complaint is transit damage - "some came open and others came crushed as if melted", "came with a squished box". Order one before publishing and check how it survives the trip. SEASONAL: an advent calendar sells Oct-Dec. Publishing it in August is early; consider holding until September.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  variant_label = excluded.variant_label, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  source_tags = excluded.source_tags, notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-072 · Mystery Dumpling Advent Calendar    RESEARCH
-- -----------------------------------------------------------
-- Landed $71.86 (free shipping) → $144.95 = 50.4% margin.
-- The genuinely expensive one you asked for - but the supplier
-- is the weakest of anything added, hence research not draft.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-072',
  'Mystery Dumpling Advent Calendar',
  'mystery',
  'The full twenty-four-day dumpling countdown — a different mystery dumpling behind every door, in a space-edition box. The most extravagant thing we stock, and squarely a gift rather than a treat.',
  144.95, 71.86, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005012583669854.html',
  null, '{}', 'Edition',
  'research', 'researching', 5.0, 2, '82',
  '{}',
  12,
  'VERIFIED 12 Aug 2026. THIS IS THE EXPENSIVE ONE - $71.86 landed, needs $144.95 retail for 50% margin. WHY RESEARCH, NOT DRAFT: the headline 5.0 rating comes from just 2 reviews, and one of those two says "I received an item that has nothing to do with what I ordered, and it arrived many days later than the scheduled delivery date". Seller Nice Party 25 Store is 83.9% positive with 6 followers - the weakest supplier of anything added in this batch. At a $145 price point a wrong-item delivery is an expensive problem. RECOMMENDATION: sq-071 is the better premium box - cheaper, 6x the sales history, better seller. If you want this one, order a sample first. Also IP-adjacent: its related-items panel is full of "Dr Pepperr" and "NeDooh" misspelled counterfeits, which says something about the neighbourhood. Free shipping, delivery 22-29 Aug, age 18+.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  variant_label = excluded.variant_label, status = excluded.status,
  research_status = excluded.research_status, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  notes = excluded.notes;

commit;

-- ===========================================================
-- CHECK IT WORKED — expect 4 rows, margins 50-65%
-- ===========================================================
--   select sku, name, category, status, price, supplier_cost,
--          round((price - supplier_cost - shipping_cost) / price * 100, 1) as margin_pct
--   from products where sku in ('sq-069','sq-070','sq-071','sq-072') order by sku;
--
-- Prism category goes from 1 product to 3, which clears the
-- "only has 1 live product" warning on the admin dashboard.
-- ===========================================================
