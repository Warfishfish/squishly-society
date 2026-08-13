-- ===========================================================
-- Migration 009 — photo galleries and real review quotes
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Covers the SIX products with the strongest review histories.
-- The rest of the catalogue still has a single photo each — see the
-- note at the bottom of this file for what's left.
--
-- EVERY IMAGE BELOW WAS LOADED AND LOOKED AT before being written in.
-- That check mattered: it caught a "SuperDeals" banner, a plain colour
-- placeholder, a wall of red warning text, and two photos of an
-- entirely different product sitting in one listing's own gallery.
-- All of those were dropped rather than shipped.
--
-- EVERY QUOTE IS REAL, copied from the supplier listing. Nothing here
-- was written by me or by you. Inventing reviews breaches the
-- Australian Consumer Law, and the product page labels these as the
-- manufacturer's reviews rather than your customers'.
--
-- Safe to re-run.
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-078 · Super Big Milk Bun          8 photos · 3 quotes
-- -----------------------------------------------------------
-- The best-documented product in the catalogue now.
-- Photos 9 and 10 in the listing's own gallery were a different
-- product in Japanese packaging, so they were left out.
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/Sdae1255630b64597baab927899a8d6e1L.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S0be321b35ca74712bbc89026b52d9b4a3.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sf7a169e50ad34b4eb76c6731e8141f5eu.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S5e83249ac8b14e52824336d4414f7360X.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S39d78fa2530f4eb68344369b7ffeb5c7W.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S70d912b3ccb144d181f01d5791d9835dK.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S93413c485de04a4babeea692000cd75c0.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S0c6da522f21043e18745a2e1d6dc9009m.jpg'
  ],
  source_quotes = '[
    {"text":"Amazing squishy. Slow rising. Amazing scent, like a sweet bun. Not like those low quality foam squishies, it literally feels like a real milk bun.","author":"AliExpress Shopper","variant":""},
    {"text":"Perfect, perfect perfect, smells soooo good, like I want a candle in this scent, and so soft it feels like you are actually squishing a real bread bun","author":"AliExpress Shopper","variant":""},
    {"text":"Is slow rising, just not as slow rising as I thought. It is soft and it smells like an absolute dream.","author":"AliExpress Shopper","variant":""}
  ]'::jsonb
where sku = 'sq-078';


-- -----------------------------------------------------------
-- sq-069 · Classic Light Prism         8 photos · 3 quotes
-- -----------------------------------------------------------
-- Photo 2 is the seller's dimensions diagram. Kept deliberately —
-- for an 80mm object, size is the question customers actually have.
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/Sdac9b15385b845649e1ebe93a2feae1bt.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S6ab4d27b02ff4a258c30be0ffb3852fez.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S68f9cbdaf2c5465b9070123a4c67c2eee.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Saee26d31f93d4da59790c35cf0dd7924I.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sb36730ca9a0e416f9de7fffd4b15b7bcx.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S2ca7a8e31aeb4af7815d16fbe378f9ebm.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/S797346d1b549498792dec035f8d35fd7o.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S0f5fe309a1154b0d80cd9cded875b89bR.jpg'
  ],
  source_quotes = '[
    {"text":"Great for studying the chromatic dispersion of light.","author":"r***r","variant":""},
    {"text":"I liked the packaging of the prism, it was super well done.","author":"AliExpress Shopper","variant":""},
    {"text":"Great quality + careful packing + fast shipping = great seller! Thanks!","author":"AliExpress Shopper","variant":""}
  ]'::jsonb
where sku = 'sq-069';


-- -----------------------------------------------------------
-- sq-083 · Honey Cheese Square         7 photos · no quotes
-- -----------------------------------------------------------
-- One gallery image was a block of red warning text and was dropped.
-- NO QUOTES ON PURPOSE: the only substantial review on this listing
-- compares the product to a NeeDoh by name. That is a trademark this
-- catalogue deliberately stays away from, and repeating it in your
-- own shop copy would undo that. Better none than that one.
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/Sef8a44356d7341508906647bad4100ef3.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S5ce14094f50d44c3b292fd8705e1ec4bJ.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S521381ec47544d6e906c664cf852b821a.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sa92afdffc52744939a61990343569565s.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sdde1e063c2974f55a2f6d4fbd9b383a84.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sc77f3953e45d41af814b6ccd2087a9fcb.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S5b683f4616574199876240ca755e5587v.jpg'
  ]
where sku = 'sq-083';


-- -----------------------------------------------------------
-- sq-093 · Giant Cookie Squish         7 photos · 2 quotes
-- -----------------------------------------------------------
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S4570ae5a9b6d4e4e9169401ab32409b0B.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sba47b6f35a1543ab87e28851b93ea58ba.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S70d44d2daa454d4286724dc6e21d7d82m.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S8a3cd54826084aa5b2e6d19ec1bcfe8fW.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Seceae337d0c8444eb478de8e57e36ab27.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sce050047fe43419a9b7e38b343eec175o.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S6ab73854dcf34980b6a49ab4f3845795G.jpg'
  ],
  source_quotes = '[
    {"text":"It is so soft and squishy, honestly the best foam squish I have ever felt. It is very fluffy and slow rising. The pink colour is super cute too, I love it.","author":"R***a","variant":""},
    {"text":"I love this! It is so soft, fluffy and squishy! It is big and smells good too, like a macaron! It is three pieces.","author":"A***e","variant":""}
  ]'::jsonb
where sku = 'sq-093';


-- -----------------------------------------------------------
-- sq-076 · Jumbo Cheese Cube           3 photos · 1 quote
-- -----------------------------------------------------------
-- ⚠️ ONLY THREE. This listing genuinely has three product photos;
-- the fourth image in its gallery was a purple "SuperDeals" banner,
-- which is advertising, not a product shot. Worth adding your own
-- photo once you have one in hand — this is the batch's best product
-- and it deserves better than three.
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S990f9bfa406a44fa8fa277b8f64a6aa8F.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sa46eef6767194392b630ef05afc72c48N.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S637e6b707b2e47c18664d0b4522f0a5aW.jpg'
  ],
  source_quotes = '[
    {"text":"This squishy is insanely good, it smells good, the perfect size and so so good to squish, like in those ASMR videos.","author":"AliExpress Shopper","variant":""}
  ]'::jsonb
where sku = 'sq-076';


-- -----------------------------------------------------------
-- sq-066 · Mystery Squish Blind Box    3 photos · no quotes
-- -----------------------------------------------------------
-- ⚠️ ONLY THREE, and no usable quote. The fourth gallery image was a
-- plain green placeholder. The reviews on this listing are mostly one
-- line long, and the one substantial review praises a NeeDoh copy that
-- came in the box — which is exactly what you do not want quoted on
-- your own product page.
update products set
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S977d91c9253240dd81838fb05546feb3J.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/S38c4e3299d7e48db92adb9a1c3cb4232f.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sa90e326018c442c09a2c1263bd5da7d9d.png'
  ]
where sku = 'sq-066';

commit;


-- ===========================================================
-- CHECK IT WORKED
-- ===========================================================
--   select sku, name,
--          coalesce(array_length(gallery,1),0) as photos,
--          jsonb_array_length(coalesce(source_quotes,'[]'::jsonb)) as quotes
--   from products
--   where sku in ('sq-066','sq-069','sq-076','sq-078','sq-083','sq-093')
--   order by sku;
--
-- And to see which products still need a gallery:
--   select sku, name, coalesce(array_length(gallery,1),0) as photos
--   from products where coalesce(array_length(gallery,1),0) < 4
--   order by sku;
-- ===========================================================


-- ===========================================================
-- WHAT'S STILL OUTSTANDING
-- ===========================================================
-- Roughly two dozen products still have a single photo: sq-065,
-- sq-067, sq-068, sq-070 to sq-075, sq-077, sq-079 to sq-082,
-- sq-084 to sq-092 and sq-094.
--
-- Each one needs its listing opened, its gallery and description
-- images pulled, and every image looked at before it goes in — the
-- checking is the slow part, and this batch shows why it can't be
-- skipped. Ask and I'll work through the rest.
--
-- Two things worth knowing before then:
--
-- 1. Four photos is not always possible. Two of the six above only
--    had three real product shots on the supplier's listing. Padding
--    those out would have meant using banners or another product's
--    photos, which is worse than showing three.
--
-- 2. The long-term fix is your own photos. Every URL here is
--    hot-linked from AliExpress and can break without warning if a
--    seller reorganises their listing. Once you're selling, shooting
--    your own product photos is the single biggest upgrade available
--    to the shop — and the only version nobody else is using.
-- ===========================================================
