-- ===========================================================
-- Migration 003 — new products from the August 2026 research
-- ===========================================================
-- Paste into Supabase → SQL Editor → New query → Run.
-- (Paste the CONTENTS of this file, not its name.)
--
-- Everything here was read from live AliExpress listings on
-- 12 August 2026, using REGULAR prices — never the "Welcome deal"
-- new-shopper price, which is a one-time discount.
--
-- NOTHING GOES LIVE FROM THIS FILE.
-- Two products are added as `draft`, two as `research`. You review
-- them in the admin and set them to Active when you're happy.
--
-- MARGIN RULE APPLIED
-- You said no negative margins. Every product below clears 45%
-- gross margin at the suggested price. The mystery-dumpling
-- products from the report are deliberately NOT here — they land
-- at $15.81-$17.74 against $8.95 Australian retail, so they
-- cannot be sold at a profit. Details in the research report.
--
-- Safe to re-run (upserts on sku).
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-065 · Giant Dumpling Squishy               DRAFT
-- -----------------------------------------------------------
-- Landed $19.22 ($16.13 + $3.09 shipping) → $34.95 = 45.0% margin.
-- Works where the mini dumplings don't, purely because a 10cm
-- novelty supports a much higher retail price than an $8.95
-- pocket-money item.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-065',
  'Giant Dumpling Squishy',
  'dumpling',
  'A properly oversized dumpling — 10cm across — that squashes flat and slowly puffs back up, packed in its own little bamboo steamer. The satisfying, filmable one: big enough to fill your hand and the frame.',
  34.95, 16.13, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012400124481.html',
  null, '{}', 'Colour',
  'draft', 4.6, 50, '1,000+',
  '{"ultra soft","fast delivery","cute design","child-friendly"}',
  true, 5,
  'VERIFIED 12 Aug 2026. Seller SunnyToyBox 95.4% positive, 64 followers - the best seller rating found in this category. No Brand Name field, so generic and IP-clean. Size 10 x 8.5 x 6.5cm. Regular price $16.13 (welcome deal was $7.73 - do not cost from that). Bulk barely helps: 3pc $15.63ea, 6pc $15.54ea. Listing warns "keep away from fire". 2 of 50 reviews mention poor quality. NEEDS PHOTO - add the main image URL from the listing before publishing.'
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
-- sq-066 · Mystery Squish Blind Box             DRAFT
-- -----------------------------------------------------------
-- Landed $12.82 ($9.73 + $3.09) → $26.95 = 52.4% margin.
-- The strongest listing found in the whole research: 4.9 stars
-- across 1,045 reviews and 10,000+ sold.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-066',
  'Mystery Squish Blind Box',
  'mystery',
  'You do not get to choose. Each box holds one random squish from the current series — popsicles, mangoes, textured cubes, and the odd rare one. Half the fun is the unboxing, which is exactly why these keep going viral.',
  26.95, 9.73, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012588695903.html',
  null, '{}', null,
  'draft', 4.9, 1045, '10,000+',
  '{"good quality","cheap and good","soft"}',
  true, 6,
  'VERIFIED 12 Aug 2026. Seller Leyu toy Store. BEST LISTING FOUND: 4.9 stars, 1045 reviews, 10,000+ sold. No Brand Name field - generic and IP-clean. Checked the product images specifically for counterfeit contents and found none (unlike other blind boxes in this category). Age 14+. Regular $9.73, welcome deal was $4.85. Some reviews ship from a US warehouse - worth asking the seller whether that is selectable, it would cut delivery time. NEEDS PHOTO before publishing.'
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
-- sq-067 · Capybara Bakery Squishy           RESEARCH
-- -----------------------------------------------------------
-- Landed $24.65 (free shipping) → $49.95 = 50.7% margin.
-- Margin works, but $49.95 is a big ask for a squishy. Parked as
-- research rather than draft for that reason.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-067',
  'Capybara Bakery Squishy',
  'dumpling',
  'A slow-rising capybara baked into a pastry — croissant, red bean bun, strawberry slice. Scented, palm-sized, and takes a satisfying few seconds to reinflate after you flatten it.',
  49.95, 24.65, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005010376544028.html',
  null, '{}', 'Style',
  'research', 'interesting', 4.9, 232, '1,000+',
  '{"very soft","slow rising","nice scent","bread-like scent","cute design"}',
  7,
  'VERIFIED 12 Aug 2026. Excellent reviews (4.9, 232 reviews, 1,000+ sold) and 14 style variants. Free shipping. Brand Name field says ISHOWTIENDA - a generic Chinese seller label, not licensed IP, so low risk. WHY RESEARCH NOT DRAFT: regular cost is $24.65, so you need $49.95 retail for 50% margin. That is a lot to ask for a squishy when Australian shops sell squishies at $6.95-$13.95. Only viable if positioned as a premium scented collectible. Note its reviews are aggregated across multiple sellers, so they are less reliable than a single-store rating.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  variant_label = excluded.variant_label, status = excluded.status,
  research_status = excluded.research_status, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  source_tags = excluded.source_tags, notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-068 · Butter & Food Mystery Box         RESEARCH
-- -----------------------------------------------------------
-- Landed $18.23 ($15.14 + $3.09) → $36.95 = 50.7% margin.
-- Second mystery box, but with real quality question marks.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-068',
  'Butter & Food Mystery Box',
  'mystery',
  'A random food-shaped squish per box — butter blocks, burgers, cheese wedges. Same surprise format, different flavour.',
  36.95, 15.14, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012465927761.html',
  null, '{}', 'Series',
  'research', 'researching', 4.9, 36, '700+',
  '{"nice to get something secret"}',
  8,
  'VERIFIED 12 Aug 2026. CAUTION - this is the second mystery box you asked for, but it is noticeably weaker than sq-066. Headline rating is 4.9 but the customer PHOTO reviews include 1.0, 2.0 and 3.0 star entries, and one buyer expected more than one item per box ("i wish i got more them one"). Only 36 reviews. One photo shows a slime tin rather than a squishy, so contents look inconsistent. Regular $15.14 is also high for a single random item. Recommend ordering one yourself before publishing. If it disappoints, sq-066 alone is a better bet than two mediocre boxes.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  variant_label = excluded.variant_label, status = excluded.status,
  research_status = excluded.research_status, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  source_tags = excluded.source_tags, notes = excluded.notes;

commit;

-- ===========================================================
-- CHECK IT WORKED
-- ===========================================================
-- Should return 4 rows, with margins between 45% and 53%:
--
--   select sku, name, category, status, price, supplier_cost, shipping_cost,
--          round((price - supplier_cost - shipping_cost) / price * 100, 1) as margin_pct
--   from products where sku in ('sq-065','sq-066','sq-067','sq-068')
--   order by sku;
--
-- ===========================================================
-- DELIBERATELY NOT ADDED
-- ===========================================================
-- - Anything NeeDoh-branded. Counterfeit; $214,000 seized 8 Aug 2026.
-- - The "Needoh Diamond Gemstone" listing: title and packaging use the
--   trademark, 3.4 stars, and the top review theme is literally
--   "fake product". Seller at 70.2% positive.
-- - "Cube & Ocean Squishy Blind Box": the product photo shows the box
--   contains counterfeit NeeDoh, Dr Pepper AND Sprite branded items.
-- - The three mystery-dumpling listings from the report: $15.81-$17.74
--   landed against $8.95 Australian retail. Negative margin.
-- - "Blind Box Colorful Simulated Dumpling": seller at 80.6% positive.
-- ===========================================================
