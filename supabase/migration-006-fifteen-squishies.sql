-- ===========================================================
-- Migration 006 — fifteen more squishies
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Read from live AliExpress listings on 12 August 2026, always
-- using the REGULAR price — never the "Welcome deal" figure,
-- which is a one-time new-shopper discount and roughly half the
-- real cost on almost every listing.
--
-- NOTHING GOES LIVE FROM THIS FILE.
-- Thirteen arrive as `draft`, two as `research`. You review them
-- in the admin and switch the ones you want to Active.
--
-- MARGIN RULE
-- Every product below clears 48% gross margin at the suggested
-- price. Nothing with a negative or thin margin was included.
--
-- TWO NEW CATEGORIES
-- This batch introduces `food` and `animal`. The matching labels,
-- tiles and filters are added in products.js and app.js — those
-- are code changes, so they need a git push as well as this SQL.
--
-- Safe to re-run (upserts on sku).
-- ===========================================================
--
-- A NOTE ON "AGGREGATE" LISTINGS — read this once
-- Many AliExpress squishy listings are what AliExpress calls a
-- "special page": the headline rating and sold count are pooled
-- across several merchants selling a similar item, not earned by
-- the one shop that would actually pack your order. The page says
-- so in small print near the bottom. Where that applies, the note
-- on the product says AGGREGATE LISTING and names the real seller.
-- Treat those ratings as weaker evidence than a single-store one.
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-073 · Watermelon Slow-Rise Squishy              DRAFT
-- -----------------------------------------------------------
-- Landed $8.26 ($5.17 + $3.09) → $17.95 = 54.0% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-073',
  'Watermelon Slow-Rise Squishy',
  'food',
  'A wedge of watermelon that squashes completely flat and then takes its time coming back. Pale green rind, pink flesh, little black seeds — the slow rebound is the whole point.',
  17.95, 5.17, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005009960363169.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S55809ebea9bd45c693f46cab16826254M.jpg_960x960q75.jpg_.avif',
  '{}', 'Pack size',
  'draft', 4.9, 6507, '100K+',
  '{"pleasant scent","slow rising","very soft","great feeling","very squishy"}',
  true, 13,
  'VERIFIED 12 Aug 2026. Cheapest unit cost in this batch and the best margin of the fifteen. No Brand Name field in Specifications - generic and IP-clean. Shipping $3.09, delivery 20-27 Aug. AGGREGATE LISTING: the 4.9 / 6,507 reviews / 100K+ sold badge is pooled across multiple merchants; the actual seller is KaiAqua Global Surprise Toys Store. Reading the reviews, most of them are for a BUTTER squishy from the same pool, not this watermelon - so treat the rating as indicative only. One reviewer reported it "started tearing". Worth ordering one before you push volume at it.'
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
-- sq-074 · Ocean Gel Cube                         RESEARCH
-- -----------------------------------------------------------
-- Landed $16.79 ($13.70 + $3.09) → $32.95 = 49.0% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-074',
  'Ocean Gel Cube',
  'mochi',
  'A clear gel cube with a tiny seascape suspended inside — starfish, shells, a drift of sand. Squeeze it and the whole scene distorts, then settles back.',
  32.95, 13.70, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005010228971023.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S7ef1f7c52f0a426c97120c3055308419g.jpg_960x960q75.jpg_.avif',
  '{}', 'Design',
  'research', 'researching', 4.9, 3197, '10,000+',
  '{"satisfying","clear gel","good quality"}',
  14,
  'VERIFIED 12 Aug 2026. Model DN001, no Brand Name field - IP-clean. Shipping $3.09, delivery 20-27 Aug, free returns. WHY RESEARCH, NOT DRAFT - two reasons. First, it is a gel-FILLED item, and gel-filled squishies are the category most prone to splitting and leaking in transit or after a few hard squeezes; the listing itself carries a "NOT EDIBLE. DO NOT SWALLOW." warning. Second, the seller trades as Shop1105482314 Store - an unnamed default storefront, which is a weaker trust signal than a named shop. AGGREGATE LISTING, so the 4.9 is pooled. Order one and squeeze it hard for a week before committing.'
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
-- sq-075 · Green Apple Squeeze Ball                  DRAFT
-- -----------------------------------------------------------
-- Landed $17.95 ($14.86 + $3.09) → $34.95 = 48.6% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-075',
  'Green Apple Squeeze Ball',
  'food',
  'A translucent green apple that gives completely under your thumb and then reinflates. Heavier and denser than it looks, which is most of the appeal.',
  34.95, 14.86, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005009695921276.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9de20148527449488dd6f167a9c167057.jpg',
  '{}', 'Colour',
  'draft', 4.9, 2598, '10,000+',
  '{"slow rebound","very soft","satisfying"}',
  true, 15,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. Shipping $3.09, delivery 21-28 Aug, free returns. Age 14+. Marketed for ADHD and autism sensory use, which is a real and growing search term in Australia, but do not repeat those health claims in your own copy - describe what it does, not what it treats. AGGREGATE LISTING; actual seller is Shop1105222277 Store, an unnamed default storefront. Margin is the thinnest of this batch at 48.6%, so there is no room to discount it. Its photo carries a "Relieve Stress Squeeze Toys" marketing overlay - fine as a placeholder, but a plain shot would sit better next to the rest of the catalogue.'
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
-- sq-076 · Jumbo Cheese Cube                         DRAFT
-- -----------------------------------------------------------
-- Landed $22.07 (FREE shipping) → $44.95 = 50.9% margin.
-- One of only three single-store listings in this batch.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-076',
  'Jumbo Cheese Cube',
  'food',
  'A two-handed block of holey cheese that squashes down to almost nothing and slowly rises back into shape. Big, absurd, and built for the camera.',
  44.95, 22.07, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005011624257131.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S990f9bfa406a44fa8fa277b8f64a6aa8F.jpg_960x960q75.jpg_.avif',
  '{}', 'Size',
  'draft', 4.4, 2381, '10,000+',
  '{"satisfying","pleasant feel","soft and squishy","super soft"}',
  true, 16,
  'VERIFIED 12 Aug 2026. NOT an aggregate listing - this is a real single-store rating from Game Plush Toys Store, which makes the 4.4 across 2,381 reviews much stronger evidence than most of this batch. FREE shipping, delivery 20-27 Aug, free returns within 90 days. No Brand Name field - IP-clean. Age 14+. ONE THING TO KNOW: "strong scent" appears in 158 reviews. For most buyers that reads as a feature, but it is worth a line in the product copy so nobody is surprised. Highest ticket price of the batch at $44.95 - justified by size, and free shipping keeps the margin healthy.'
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
-- sq-077 · Rainbow Dumpling in a Steamer             DRAFT
-- -----------------------------------------------------------
-- Landed $16.15 ($13.06 + $3.09) → $32.95 = 51.0% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-077',
  'Rainbow Dumpling in a Steamer',
  'dumpling',
  'A rainbow-gradient dumpling with a little sleeping face, packed in its own bamboo steamer. Slow-rising, palm-sized, and it stores itself.',
  32.95, 13.06, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012098568840.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S6e64b560d7f4410e95c7f1b9e5e83c86O.jpg_960x960q75.jpg_.avif',
  '{}', 'Colour',
  'draft', 4.4, 789, '5,000+',
  '{"excellent","enjoyable","satisfied"}',
  true, 17,
  'VERIFIED 12 Aug 2026. NOT an aggregate listing - sold by CHUTAI Toy Store, and the Brand Name field says CHUTAI, which is the seller''s own generic house label rather than anyone else''s trademark. IP-clean. Shipping $3.09, delivery 19-25 Aug. CAUTION: the single most-mentioned review tag is "strong odor" (31 of 789). New PVC squishies commonly smell for a few days and then settle, but at a 4.4 rating it is the main thing holding the score down. Airing stock out of the packaging before dispatch would help. Photo carries a "Dumpling Squishy Toys" title overlay.'
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
-- sq-078 · Super Big Milk Bun                        DRAFT
-- -----------------------------------------------------------
-- Landed $12.07 ($8.98 + $3.09) → $24.95 = 51.6% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-078',
  'Super Big Milk Bun',
  'food',
  'An oversized pillowy milk bun with a faint bakery smell and a properly slow rise. Two hands to squash, several seconds to come back.',
  24.95, 8.98, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005010487320586.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sdae1255630b64597baab927899a8d6e1L.jpg_960x960q75.jpg_.avif',
  '{}', null,
  'draft', 4.9, 613, '5,000+',
  '{"pleasant scent","soft texture","slow rising","pleasant to touch","nice texture"}',
  true, 18,
  'VERIFIED 12 Aug 2026. One of the cleanest review profiles in the batch - every one of the top six tags is positive, with no quality, smell or breakage complaint anywhere near the top. No Brand Name field - IP-clean. Shipping $3.09, delivery 19-25 Aug. Age 12+. AGGREGATE LISTING; actual seller is DongJ Store. Good low-risk starter: cheap to sample, sits at a comfortable $24.95, and the "slow rising" tag is exactly what the format is bought for. If you only test three from this batch, make this one of them.'
)
on conflict (sku) do update set
  name = excluded.name, category = excluded.category,
  description = excluded.description, price = excluded.price,
  supplier_cost = excluded.supplier_cost, shipping_cost = excluded.shipping_cost,
  supplier_name = excluded.supplier_name, supplier_url = excluded.supplier_url,
  image = excluded.image, source_rating = excluded.source_rating,
  source_reviews = excluded.source_reviews, source_orders = excluded.source_orders,
  source_tags = excluded.source_tags, notes = excluded.notes;


-- -----------------------------------------------------------
-- sq-079 · Cheese Cake Squish                        DRAFT
-- -----------------------------------------------------------
-- Landed $14.38 ($11.29 + $3.09) → $28.95 = 50.3% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-079',
  'Cheese Cake Squish',
  'food',
  'A little golden cheese cake that gives like the real thing and smells faintly of one. Chewy rather than airy — the texture people mean when they say "satisfying".',
  28.95, 11.29, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005010806632142.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4bca6edeaf63415faf5bf93ccf3e23dbW.jpg_960x960q75.jpg_.avif',
  '{}', 'Style',
  'draft', 4.9, 518, '5,000+',
  '{"super soft","soft texture","nice and chewy","pleasant scent","nice to touch"}',
  true, 19,
  'VERIFIED 12 Aug 2026. Listing title says "Cheese Bread" but the actual product photo is a small cheese cake, which is why it is named Cheese Cake Squish here - describe what arrives, not what the listing calls it. No Brand Name field - IP-clean. Shipping $3.09, delivery 19-26 Aug. Age 14+. AGGREGATE LISTING; actual seller is BingWu03 Store. Review profile is clean - all six top tags positive. PHOTO NOTE: the image has Chinese text overlaid on it. Fine as a placeholder, but pick a plainer gallery shot before you publish.'
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
-- sq-080 · Giant Strawberry Squishy                  DRAFT
-- -----------------------------------------------------------
-- Landed $18.51 ($15.42 + $3.09) → $37.95 = 51.2% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-080',
  'Giant Strawberry Squishy',
  'food',
  'A strawberry the size of both fists, dimpled and deep red, that holds whatever shape you squash it into for a second before easing back.',
  37.95, 15.42, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012258501766.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S591c4342cdbf4fe3add32dae644335b0C.jpg_960x960q75.jpg_.avif',
  '{}', 'Size',
  'draft', 4.9, 447, '5,000+',
  '{"satisfying","pleasant","impressive","lots of air"}',
  true, 20,
  'VERIFIED 12 Aug 2026. WATCH THE VARIANT PRICING ON THIS ONE. The costing above uses the default size at a regular price of $15.42. The listing also sells a much larger size at $47.40 regular - if you ever order that variant, the $37.95 retail here goes underwater immediately. Model AL-001, no Brand Name field - IP-clean. Warning on the listing: "Cannot eat". Shipping $3.09, delivery 20-26 Aug, free returns. AGGREGATE LISTING; actual seller is HS Toy Store. Only 8 detailed ratings behind the tag list, so the review evidence is thinner than the 447 headline suggests.'
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
-- sq-081 · Dumpling Trio in Steamers                 DRAFT
-- -----------------------------------------------------------
-- Landed $15.97 (FREE shipping) → $32.95 = 51.5% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-081',
  'Dumpling Trio in Steamers',
  'dumpling',
  'Three pleated buns in pastel colours, each in its own little steamer basket. Stackable, collectable, and the set photographs better than any single one does.',
  32.95, 15.97, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005008248070609.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1444eced2b56453c999d39f4c6f4d9132.jpg_960x960q75.jpg_.avif',
  '{}', 'Colour',
  'draft', 4.9, 586, '5,000+',
  '{"good quality","perfect","highly recommend","fast delivery"}',
  true, 21,
  'VERIFIED 12 Aug 2026. FREE shipping, delivery 20-27 Aug - free shipping is what makes this one work at $32.95. No Brand Name field - IP-clean. Age 12+. AGGREGATE LISTING; actual seller is Shop1105167553 Store, an unnamed default storefront. The detailed rating spread includes a 3.0, so the 4.9 headline is doing some rounding. Pairs obviously with sq-077 and the existing sq-065 giant dumpling - between them the Dumplings category now has enough depth to stand on its own tile.'
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
-- sq-082 · Toast Slice Squish                        DRAFT
-- -----------------------------------------------------------
-- Landed $10.59 ($7.50 + $3.09) → $21.95 = 51.8% margin.
-- ⚠️ The only one of the fifteen with NO photo. See note.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-082',
  'Toast Slice Squish',
  'food',
  'A thick slice of white bread that flattens completely and comes back with the crust still square. Faintly coffee-scented, oddly convincing.',
  21.95, 7.50, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005012434155878.html',
  null, '{}', 'Style',
  'draft', 4.9, 508, '5,000+',
  '{"slow rising","accurate to pictures","cute design","pleasant smell","coffee scent"}',
  true, 22,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. Shipping $3.09, delivery 19-25 Aug. AGGREGATE LISTING; actual seller is Car All Around Enthusiast Store. Second-cheapest landed cost in the batch, which is why it can sit at a pocket-money-adjacent $21.95. NEEDS A PHOTO - this is the only one of the fifteen I could not get right. The image the page served was a pink glittery cube, which is plainly not a slice of toast, so I left the field empty rather than publish something wrong. To fix, 30 seconds: open the listing, right-click the main product photo, "Copy image address", then paste it into Admin > Products > Toast Slice Squish > Main image URL.'
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
-- sq-083 · Honey Cheese Square                       DRAFT
-- -----------------------------------------------------------
-- Landed $17.04 ($13.95 + $3.09) → $34.95 = 51.2% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-083',
  'Honey Cheese Square',
  'mochi',
  'A translucent amber block that stretches, sags and slowly gathers itself back up. Firmer than a mochi ball at first, then softer the more you work it.',
  34.95, 13.95, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005011587273406.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sef8a44356d7341508906647bad4100ef3.jpg_960x960q75.jpg_.avif',
  '{}', 'Pack size',
  'draft', 4.9, 1145, '10,000+',
  '{"satisfying","soft and squishy","moderately firm yet soft","softens with use","amazing texture"}',
  true, 23,
  'VERIFIED 12 Aug 2026. Strongest review profile of the batch after sq-076: 4.9 across 1,145 reviews, 10,000+ sold, and the top tags describe the texture in unusual detail - "moderately firm yet soft", "softens with use", "amazing texture". That specificity usually means real buyers rather than padded reviews. No Brand Name field - IP-clean. Warning: "Not edible". Shipping $3.09, delivery 19-25 Aug. Age 14+. Sold in 1 / 2 / 6pc, so there is an obvious multipack variant to add later. AGGREGATE LISTING; actual seller is S Heng Store. Filed under Mochi rather than Food - it behaves like the maltose and mochi blobs already in that category.'
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
-- sq-084 · Aurora Glitter Duck                       DRAFT
-- -----------------------------------------------------------
-- Landed $13.75 ($10.66 + $3.09) → $27.95 = 50.8% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-084',
  'Aurora Glitter Duck',
  'animal',
  'A see-through duck full of suspended glitter that shifts colour as it catches the light. Stretches long, squashes flat, and looks good just sitting on a shelf.',
  27.95, 10.66, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005011822897554.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S7a8b8874a805412dae82a68beaa5630f8.png_960x960.png_.avif',
  '{}', 'Colour',
  'draft', 4.9, 676, '5,000+',
  '{"enjoyable","soft and squishy","stress relieving","cute design","appealing to kids"}',
  true, 24,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean, which matters here because the duck/goose squish category is full of licensed lookalikes. Shipping $3.09, delivery 20-26 Aug, free returns. Listing says age 18+, but the review tags include "appealing to kids" - the age rating is almost certainly the seller covering themselves on small parts rather than a real content warning. Keep the 18+ note visible on your own listing anyway. AGGREGATE LISTING; actual seller is Mingli Store. Clean review profile, no quality or breakage complaints in the top tags. First product in the new Animals category.'
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
-- sq-085 · Bubble Burger Bear                        DRAFT
-- -----------------------------------------------------------
-- Landed $12.14 ($9.05 + $3.09) → $24.95 = 51.3% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-085',
  'Bubble Burger Bear',
  'animal',
  'A small bear tucked into a burger bun who blows a bubble when you squeeze him. Completely silly, and the bubble is the bit that makes people pick it up twice.',
  24.95, 9.05, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005011942960291.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc89a675627af49728e661d5a4e487804K.jpg_960x960q75.jpg_.avif',
  '{}', 'Pack size',
  'draft', 4.9, 693, '5,000+',
  '{"cute design","fast delivery","great quality","high quality"}',
  true, 25,
  'VERIFIED 12 Aug 2026. No Brand Name field - IP-clean. The bear is a generic kawaii character, not a licensed one, which is the thing to keep checking if you ever swap suppliers on this style. Shipping $3.09, delivery 19-26 Aug. Age 14+. Sold in 1 or 4pc. AGGREGATE LISTING; actual seller is Jianan Technology Store. Only 18 detailed ratings behind the tags, so the evidence is thinner than the 693 headline. The bubble mechanism is a moving part, which is more to go wrong than a plain squish - sample one and work it a hundred times before publishing.'
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
-- sq-086 · Squeaky Goose Squish                   RESEARCH
-- -----------------------------------------------------------
-- Landed $15.69 ($12.60 + $3.09) → $31.95 = 50.9% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, research_status, source_rating, source_reviews, source_orders,
  source_tags, sort_order, notes
) values (
  'sq-086',
  'Squeaky Goose Squish',
  'animal',
  'A bright yellow goose that flattens with a squawk and springs back up. The loudest thing in the shop, which is either the point or the problem.',
  31.95, 12.60, 3.09,
  'AliExpress', 'https://www.aliexpress.com/item/1005010425273195.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1047dcbce6e44028ad5e2435efa2e186T.jpg_960x960q75.jpg_.avif',
  '{}', 'Size',
  'research', 'researching', 4.5, 841, '10,000+',
  '{"great product","cute design","pleasant texture","fun to squeeze"}',
  26,
  'VERIFIED 12 Aug 2026. NOT an aggregate listing - real single-store rating from S Heng Store, the same seller as sq-083. That makes the 4.5 trustworthy, and it is the trustworthiness that is the problem: "poor quality" appears in 37 of the top review tags and "small size" in 35. Both are real signals, not noise. WHY RESEARCH, NOT DRAFT: a returns problem at $31.95 costs more than this product earns. WATCH THE VARIANT PRICING - the costing uses the default size at $12.60 regular; a larger variant runs to $51.20, which would sink the $31.95 retail. No Brand Name field - IP-clean. Warning: "Keep away from fire". Free returns, delivery 19-25 Aug. Order one, check the size against the photo, and only promote it if it arrives bigger than the reviewers expected.'
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
-- sq-087 · Croissant Squish                          DRAFT
-- -----------------------------------------------------------
-- Landed $13.77 (FREE shipping) → $27.95 = 50.7% margin.
insert into products (
  sku, name, category, description,
  price, supplier_cost, shipping_cost,
  supplier_name, supplier_url, image, gallery, variant_label,
  status, source_rating, source_reviews, source_orders,
  source_tags, is_new_drop, sort_order, notes
) values (
  'sq-087',
  'Croissant Squish',
  'food',
  'A life-sized croissant, layered and burnished, that squashes into a crescent and unfolds itself again. Scented, and close enough to the real thing to fool people at arm''s length.',
  27.95, 13.77, 0,
  'AliExpress', 'https://www.aliexpress.com/item/1005012013888784.html',
  'https://ae-pic-a1.aliexpress-media.com/kf/S34cdfa8bc99c4410b35d17016dce88a5E.jpg_960x960q75.jpg_.avif',
  '{}', 'Style',
  'draft', 4.9, 122, '1,000+',
  '{"scented","super soft and squishy","slow-release texture","realistic size","cute design"}',
  true, 27,
  'VERIFIED 12 Aug 2026. FREE shipping, delivery 19-25 Aug - which is what makes 50.7% possible on a $13.77 unit. No Brand Name field - IP-clean. Age 14+. THINNEST SALES HISTORY OF THE BATCH: 122 reviews and 1,000+ sold, against 5,000-100,000 for everything else here. The reviews themselves are good and specific ("realistic size", "slow-release texture"), but there are not many of them, so this is the one most likely to disappoint. AGGREGATE LISTING; actual seller is Shop1105586155 Store, an unnamed default storefront. Sample before publishing.'
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
-- CHECK IT WORKED — expect 15 rows, every margin 48%+
-- ===========================================================
--   select sku, name, category, status, price, supplier_cost, shipping_cost,
--          round((price - supplier_cost - shipping_cost) / price * 100, 1) as margin_pct
--   from products where sku between 'sq-073' and 'sq-087' order by sku;
--
-- And to see the whole catalogue by category:
--   select category, count(*), count(*) filter (where status = 'active') as live
--   from products group by category order by category;
-- ===========================================================


-- ===========================================================
-- DELIBERATELY NOT ADDED — and why
-- ===========================================================
-- Six listings were checked and rejected. Each one is the kind of
-- thing that looks fine on a search-results card:
--
-- 1. "NEEDOH Textured Slow Rebound Gel Stress Ball" — uses the
--    NeeDoh trademark outright. Counterfeit, same as every other
--    NeeDoh listing on the platform. $214,000 seized 8 Aug 2026.
--
-- 2. "Taba Squishy Stress Balls Cube" — the title uses the
--    TabaSquishy brand name while the Brand Name field in the
--    Specifications says CHUTAI. A product branded as one thing
--    and titled as another is trademark piggybacking, which is
--    the exact pattern that got the Chiikawa keychains removed
--    earlier in this project. Separately, 74 reviews mention a
--    "strong weird smell".
--
-- 3. "Steamed Bun Squeeze Toy" — 3.9 stars, and the single
--    most-mentioned review tag across 1,670 reviews is
--    "easily broken" (201 mentions). Not a borderline call.
--
-- 4. "Mystery Fidget Toy Kawaii Cat's Paw" — the listing header
--    literally advertises "Selected Trending IP Products".
--    Anything selling itself on IP is the wrong neighbourhood.
--
-- 5. "Squishy Simulated Cake Squeeze Toy" — margin was fine, but
--    the listing now reads "Sorry, this item is no longer
--    available". Dead supplier.
--
-- 6. "Colorful Squeezable Toy Stress Relief" — $15.86 regular for
--    one small squish, sold by an unnamed default storefront.
--    Would have needed a $39.95 retail price to work. Not worth it.
-- ===========================================================
