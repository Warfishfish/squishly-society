-- ===========================================================
-- Migration 005 — product photos
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Adds the main photo to the 8 products from migrations 003 and 004.
-- Every URL below was pulled from the live listing and then LOADED
-- AND VIEWED to confirm it shows the right product — not assumed
-- from the page source.
--
-- Consistent with the rest of the catalogue, these are hot-linked
-- from AliExpress's CDN. That works today, but the links can break
-- without warning if a seller reorganises their listing. Worth
-- re-hosting the winners on your own storage eventually.
--
-- Safe to re-run.
-- ===========================================================

begin;

-- sq-065 · Giant Dumpling Squishy
-- Gold glitter dumpling in its bamboo steamer, with the 10cm / 8.5cm
-- / 6.5cm dimensions marked on the image. The size callout is doing
-- real work here — "giant" is the whole selling point.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc078691382a74118a094474a2939521e3.jpg_960x960q75.jpg_.avif'
where sku = 'sq-065';

-- sq-066 · Mystery Squish Blind Box
-- Someone holding an open cardboard box spilling with squishies.
-- Good, clean, and it sells the "what will I get" idea immediately.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/S977d91c9253240dd81838fb05546feb3J.png_960x960.png_.avif'
where sku = 'sq-066';

-- sq-068 · Butter & Food Mystery Box
-- Food squishies spilling from a box. Has a "MYSTERY BOX" graphic
-- overlaid — a bit busy, but legible and on-message.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/S3feb01c06f014fd79d105cad5078a13eY.jpg_960x960q75.jpg_.avif'
where sku = 'sq-068';

-- sq-069 · Classic Light Prism
-- Prism on its black display stand throwing a rainbow onto a white
-- surface. The best photo of the batch — clean, bright, obvious.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/Sdac9b15385b845649e1ebe93a2feae1bt.jpg_960x960q75.jpg_.avif'
where sku = 'sq-069';

-- sq-070 · Giant Light Prism
-- Hand holding the full 200mm prism against black, rainbow across
-- its face. The hand gives the scale, which is the point of this one.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa4b65f9dac104214816cafead5c80b6cw.jpg_960x960q75.jpg_.avif'
where sku = 'sq-070';

-- sq-071 · 24-Day Squishy Advent Calendar
-- ⚠️ WEAKEST PHOTO OF THE SET. This is the seller's marketing
-- infographic — a "WHY YOU'LL LOVE IT?" panel with feature bullets
-- down the side — rather than a clean product shot. It will look
-- out of place next to your other images. Fine as a placeholder,
-- but open the listing and pick a plainer gallery shot before you
-- publish this one.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd0e70c67ae0d4a25bfacb4b83e0c3a47F.png_960x960.png_.avif'
where sku = 'sq-071';

-- sq-072 · Mystery Dumpling Advent Calendar
-- Space-edition calendar box with the dumpling characters.
update products set image =
  'https://ae-pic-a1.aliexpress-media.com/kf/S21fe4e0f49974f8eaf287ddc486d8ca2I.jpg_960x960q75.jpg_.avif'
where sku = 'sq-072';

commit;

-- ===========================================================
-- sq-067 · Capybara Bakery Squishy — STILL NEEDS A PHOTO
-- ===========================================================
-- This is the only one I could not retrieve. That listing
-- repeatedly tripped the browser tool's security filter, on four
-- separate attempts including hard reloads. Nothing sinister —
-- just that one page.
--
-- To add it yourself, 30 seconds:
--   1. Open https://www.aliexpress.com/item/1005010376544028.html
--   2. Right-click the main product photo → "Copy image address"
--   3. Admin → Products → Capybara Bakery Squishy → paste into
--      "Main image URL" → Save
--
-- Lowest priority of the eight: it's a Research item, parked
-- because $24.65 landed needs a $49.95 retail price.
-- ===========================================================

-- ===========================================================
-- CHECK IT WORKED — expect 7 rows with a URL, sq-067 blank
-- ===========================================================
--   select sku, name, case when image is null then '-- MISSING --'
--          else 'ok' end as photo
--   from products where sku between 'sq-065' and 'sq-072' order by sku;
-- ===========================================================
