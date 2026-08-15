-- ===========================================================
-- Migration 013 — remove "free shipping" claims from descriptions
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- WHY THIS MATTERS
-- Three live products carried the sentence "Free shipping on this
-- listing." in their customer-facing description. That line was
-- originally a note about the SUPPLIER offering free shipping to us —
-- but on the shop it reads as a promise from Squishy Society to the
-- customer.
--
-- The store no longer advertises free shipping (it has been replaced
-- by 10% off orders over $50). Leaving these lines in place would
-- advertise a benefit the checkout does not give, which is misleading
-- conduct under Australian Consumer Law — the same rule that keeps the
-- review wording honest elsewhere in this catalogue.
--
-- The sentence is removed and the surrounding text left intact. The
-- double space it leaves behind is tidied up too.
--
-- Safe to re-run: if the sentence is already gone, nothing changes.
-- ===========================================================

begin;

update products
   set description = regexp_replace(description, '\s*Free shipping on this listing\.\s*', ' ', 'gi')
 where description ilike '%free shipping on this listing%';

-- Tidy any doubled spaces the removal may have left, and trim the ends.
update products
   set description = btrim(regexp_replace(description, '[ ]{2,}', ' ', 'g'))
 where description like '%  %'
    or description <> btrim(description);

commit;


-- ===========================================================
-- CHECK IT WORKED — both queries must return NOTHING
-- ===========================================================
--   select sku, description from products
--   where description ilike '%free shipping%';
--
--   select sku, description from products
--   where description like '%  %';
-- ===========================================================


-- ===========================================================
-- WHAT THE THREE DESCRIPTIONS SHOULD READ AFTERWARDS
-- ===========================================================
-- sq-002  A bucket of assorted mini mochi-style animal squishies that
--         glow in the dark — great as a party favour bundle or
--         pick-and-mix item. Comes in four pack sizes, priced
--         differently.
--
-- sq-011  A soft plush dumpling-shaped keychain with a stitched-on
--         smiley face — cute, pillowy, and instantly recognisable.
--         Sold in packs of 1 to 5, priced per pack.
--
-- sq-018  Pastel mechanical-style keycaps on a keyring, purely for
--         clicking. Comes as a single cube, a row of four, a cross of
--         five, or a full 3x3 grid of nine.
-- ===========================================================
