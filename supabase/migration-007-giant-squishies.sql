-- ===========================================================
-- Migration 007 — the Giants category
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Seven oversized squishies, all in a new `giant` category.
-- Read from live AliExpress listings on 12 August 2026, always at
-- the REGULAR price, never the "Welcome deal" figure.
--
-- Five arrive as `draft`, two as `research`. Nothing goes live
-- from this file — you switch things on in the admin.
--
-- Every product clears 50% gross margin.
--
-- The `giant` category label, tile and filter are added in
-- products.js and app.js, which is a git push rather than SQL.
--
-- Safe to re-run (upserts on sku).
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-088 · Giant Chick Squishy                       DRAFT
-- -----------------------------------------------------------
-- Landed $9.51 (FREE shipping) → $19.95 = 52.3% margin.
-- Cheapest way into the category and the most giftable of the seven.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-088',
  'Giant Chick Squishy',
  'giant',
  'A round yellow chick that fills your palm, squashes into a pancake and takes several seconds to puff back into a bird. Faintly scented, and it looks mildly offended the whole time.',
  19.95, 9.51, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005010299905816.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa7f38963250a4065864ec760d5da62ce2.jpg_960x960q75.jpg_.avif',
  '{}', 'Colour',
  'draft', 4.7, 335, '3,000+',
  '{"cute design","slow rising","soft texture","pleasant smell","satisfying purchase"}',
  true, 28,
  'VERIFIED 12 Aug 2026. NOT an aggregate listing - a real single-store rating, which makes 4.7 across 335 reviews decent evidence. FREE shipping, delivery from 19 Aug. Brand Name field says ISHOWTIENDA, the same generic Chinese seller label already on sq-067; it is a house brand, not licensed IP, so the risk is low. Age 14+. THE ONE CATCH: "small size" appears in 12 reviews, which is awkward for something sold as giant. Measure one when it arrives and, if it is closer to palm-sized than giant, either reprice it or move it out of this category. Cleanest photo of the seven.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-089 · Giant Butter Stick                        DRAFT
-- -----------------------------------------------------------
-- Landed $11.64 (FREE shipping) → $23.95 = 51.4% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-089',
  'Giant Butter Stick',
  'giant',
  'An outsized block of butter, cool and slightly tacky to the touch, that dents under a finger and slowly smooths itself out again. Deeply silly and weirdly convincing.',
  23.95, 11.64, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005010196759718.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc3d452eee932471dbdb62fbe2a805d87O.jpg',
  '{}', 'Size',
  'draft', 4.6, 196, '2,000+',
  '{"very squishy","satisfying","excellent quality"}',
  true, 29,
  'VERIFIED 12 Aug 2026. NOT an aggregate listing. FREE shipping, delivery from 19 Aug. Age 14+. Comes in a small and a super big stick - the costing here is the big one, so check the variant when ordering. TWO THINGS TO WATCH. First, "weird smell" appears in 12 of 196 reviews against "pleasant smell" in 7, so opinion is genuinely split; air stock before dispatch. Second, the Brand Name field reads "Hot Toys", which is also the name of a well-known licensed collectibles company. This is a name collision on an AliExpress house brand rather than that company''s product - they make sixth-scale figures, not squishies - but do not put the words "Hot Toys" anywhere in your own listing. PHOTO: it is the seller''s infographic over real butter packaging, with text overlays. Swap for a plain shot before publishing.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-090 · Chubby Banana Squish                      DRAFT
-- -----------------------------------------------------------
-- Landed $11.15 (FREE shipping) → $22.95 = 51.4% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-090',
  'Chubby Banana Squish',
  'giant',
  'A banana that has clearly been enjoying itself — short, fat and grinning, with a slow rebound and a slightly tacky finish that makes it stick to your palm.',
  22.95, 11.15, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005012655730138.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S699e443cb74a41ca88e075417dafbd59n.jpeg_960x960q75.jpeg_.avif',
  '{}', 'Style',
  'draft', 4.9, 163, '1,000+',
  '{"super cute","sticky and good to squish","good quality","perfectly sticky","soft to the touch"}',
  true, 30,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. FREE shipping, delivery from 20 Aug. Age 14+. Same seller as sq-087 croissant (Shop1105586155 Store), so if you sample one you learn something about both. Review tags are unusually specific about the tacky finish - "sticky and good to squish", "perfectly sticky" - which reads as a genuine texture rather than a defect, but it does mean it will pick up lint. Say so in the copy. THIN HISTORY: 163 reviews, 1,000+ sold, and it is an AGGREGATE LISTING, so treat the 4.9 as indicative. PHOTO: busy seller collage with overlay text and another shop''s watermark. Replace before publishing.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-091 · Big Peanut Squish                      RESEARCH
-- -----------------------------------------------------------
-- Landed $17.30 ($14.21 + $3.09) → $34.95 = 50.5% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-091',
  'Big Peanut Squish',
  'giant',
  'An enormous peanut in its shell, textured all over and heavier in the hand than it looks. Squeezes down to a lump and takes its time recovering.',
  34.95, 14.21, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012258288760.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9762be39937846efa5f3382327834ccfz.jpg_960x960q75.jpg_.avif',
  '{}', 'Size',
  'research', 'interesting', 4.6, 72, '1,000+',
  '{"cute design","soft","large size"}',
  31,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. Shipping $3.09, delivery 20-26 Aug, free returns. Age 14+. WHY RESEARCH, NOT DRAFT: 72 reviews with only 9 detailed ratings behind them is the thinnest evidence of the seven, the seller is an unnamed default storefront (Shop1105517006 Store), and "unpleasant smell" already appears in 3 of those 9. At $34.95 retail that is not enough to go on. The good news is "large size" is a top tag, so it does at least deliver on giant - which is more than sq-088 can promise. Sample before promoting.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  status = excluded.status, research_status = excluded.research_status,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-092 · Jumbo Pickle Squish                    RESEARCH
-- -----------------------------------------------------------
-- Landed $11.95 ($8.86 + $3.09) → $24.95 = 52.1% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-092',
  'Jumbo Pickle Squish',
  'giant',
  'A full-length pickle, bumpy and improbably green, that bends double and slowly straightens out. The most ridiculous thing in the shop, which is entirely the point.',
  24.95, 8.86, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012474931385.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd4885fb1df344596a37d817f6f6861fc4.jpg_960x960q75.jpg_.avif',
  '{}', 'Colour',
  'research', 'interesting', 4.9, 56, '1,000+',
  '{}',
  32,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. Shipping $3.09, delivery 19-26 Aug. Age 12+. WHY RESEARCH, NOT DRAFT: the 4.9 rests on 56 reviews and there are ZERO detailed photo ratings behind it - the review tag list is completely empty, which is unusual and means there is almost nothing to read about how it actually performs. AGGREGATE LISTING, unnamed seller (Shop1105455188 Store). Strong margin and genuinely funny, but this is the least-evidenced product in the batch. Order one before it goes anywhere near the shop.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  status = excluded.status, research_status = excluded.research_status,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-093 · Giant Cookie Squish                       DRAFT
-- -----------------------------------------------------------
-- Landed $16.92 ($13.83 + $3.09) → $34.95 = 51.6% margin.
-- Best review profile of the seven.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-093',
  'Giant Cookie Squish',
  'giant',
  'An oversized cream-filled cookie that compresses to a wafer and slowly rebuilds itself. Scented, soft the whole way through, and satisfying in a way that is hard to put down.',
  34.95, 13.83, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005009469774156.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4570ae5a9b6d4e4e9169401ab32409b0B.jpg',
  '{}', 'Style',
  'draft', 4.6, 339, '2,000+',
  '{"very soft","good scent","highly recommended","very nice and squishy","super soft"}',
  true, 33,
  'VERIFIED 12 Aug 2026. THE PICK OF THIS BATCH. NOT an aggregate listing, 4.6 across 339 real reviews, and the top five tags are all positive with no quality, size or smell complaint anywhere near them - which is rare in this category. Brand Name ISHOWTIENDA (generic house label, same as sq-088). Shipping $3.09, delivery 19-26 Aug. Age 14+. "sticky" appears in 24 reviews, so expect the same lint-attracting finish as sq-090. PHOTO is a slightly cluttered in-hand shot with several products visible; workable, but a plainer one would be better.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-094 · Cream Strawberry Jumbo                    DRAFT
-- -----------------------------------------------------------
-- Landed $13.89 ($10.80 + $3.09) → $28.95 = 52.0% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-094',
  'Cream Strawberry Jumbo',
  'giant',
  'A strawberry the size of a grapefruit, dimpled and cream-scented, with a proper slow rise. Smells like dessert and behaves like a stress ball.',
  28.95, 10.80, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005008500726282.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb1044a3b722c4610882d4dcb8f0d0429z.jpg_960x960q75.jpg_.avif',
  '{}', 'Size',
  'draft', 4.9, 659, '5,000+',
  '{"large size","excellent quality","fun to use","good foam squishy","fast delivery"}',
  true, 34,
  'VERIFIED 12 Aug 2026. 11.5 x 9cm, Model CT121, no Brand Name field - IP-clean. Shipping $3.09, delivery 20-26 Aug, free returns. AGGREGATE LISTING; actual seller is Shop1104361007 Store. Top review tag is "large size", so it delivers on the promise. OVERLAP WARNING: you already have sq-080 Giant Strawberry at $37.95. Two strawberries in one shop is one too many. This one is $9 cheaper to land, cream-scented, and has 659 reviews against sq-080''s 447 - so if you only keep one, keep this one and archive sq-080. The photo carries a small "CHU TAI" seller mark at the bottom.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, variant_label = excluded.variant_label,
  source_rating = excluded.source_rating, source_reviews = excluded.source_reviews,
  source_orders = excluded.source_orders, source_tags = excluded.source_tags,
  notes = excluded.notes;

commit;


-- ===========================================================
-- CHECK IT WORKED — expect 7 rows, every margin 50%+
-- ===========================================================
--   select sku, name, status, price, supplier_cost, shipping_cost,
--          round((price - supplier_cost - shipping_cost) / price * 100, 1) as margin_pct
--   from products where category = 'giant' order by sku;
-- ===========================================================


-- ===========================================================
-- OPTIONAL — move the giants you already own into the category
-- ===========================================================
-- Four products from earlier batches are arguably giants too, but
-- they were filed elsewhere before this category existed. Moving
-- them makes the Giants tile look properly stocked; leaving them
-- keeps Food and Dumplings from thinning out. Your call.
--
-- To move them, delete the two dashes at the start of the line
-- below and run just that statement:
--
-- update products set category = 'giant'
--  where sku in ('sq-065','sq-076','sq-080');
--
--   sq-065  Giant Dumpling Squishy   (currently dumpling)
--   sq-076  Jumbo Cheese Cube        (currently food)
--   sq-080  Giant Strawberry Squishy (currently food)
--
-- sq-070 Giant Light Prism is deliberately NOT in that list -
-- it belongs with the other prisms, which are a different kind
-- of product entirely.
-- ===========================================================


-- ===========================================================
-- DELIBERATELY NOT ADDED
-- ===========================================================
-- 1. "100+ Pieces Assorted Squishy Figures Blind Box" — 3.5 stars,
--    and the single most-mentioned review tag is "only one squishy"
--    (48 mentions). A buyer question on the listing reads "I only
--    received one squishy, it's a scam." The listing is misleading
--    on its face.
--
-- 2. "Giant Cheese Squeeze Toy Extra Large" — 4.1 stars with
--    "poor quality" as the top tag (8 of 14 detailed ratings).
--    You already have a far better cheese in sq-076.
--
-- 3. "Jumbo Squishy Yellow Duck / Goose" — too close to sq-086,
--    which is already parked in Research over quality complaints.
--    No point buying the same problem twice.
-- ===========================================================
