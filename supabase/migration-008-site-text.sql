-- ===========================================================
-- Migration 008 — editable site text
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Adds a read-only public view over the settings table so the shop
-- can pick up wording you change in Admin → Site text.
--
-- SECURITY NOTE — this is the part that matters.
-- The settings table also holds operational values (shipping
-- thresholds, contact details, and anything you add later). It stays
-- locked to signed-in admins. The view below exposes ONLY keys that
-- begin with a known site-text prefix, so a new setting is private by
-- default and can never leak just because someone added a row.
--
-- Safe to re-run.
-- ===========================================================

begin;

drop view if exists public_settings;

create view public_settings as
  select s.key, s.value
  from settings s
  where s.key like 'home\_%'
     or s.key like 'pdp\_%';

-- Anonymous shoppers may read the view, and nothing else.
revoke all on settings from anon;
grant select on public_settings to anon, authenticated;

commit;


-- ===========================================================
-- CHECK IT WORKED
-- ===========================================================
--   select * from public_settings order by key;
--
-- An empty result is normal until you save something in
-- Admin → Site text. The shop uses its built-in wording until then,
-- so nothing breaks in the meantime.
--
-- To confirm the boundary holds, this should return NOTHING:
--   select * from public_settings where key not like 'home\_%'
--                                   and key not like 'pdp\_%';
-- ===========================================================
