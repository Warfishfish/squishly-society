-- ===========================================================
-- Migration 012 — expose business details to the public site
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Migration 008 created a public_settings view that lets anonymous
-- visitors read only the keys beginning home_ or pdp_. This adds a
-- third prefix, site_, which currently carries the ABN shown in the
-- footer of every page.
--
-- The rule stays the same and is the point of the design: the
-- settings table can hold anything, and nothing reaches the public
-- site unless its key starts with one of three known prefixes. A
-- setting you add later is private by default.
--
-- Safe to re-run.
-- ===========================================================

begin;

drop view if exists public_settings;

create view public_settings as
  select s.key, s.value
  from settings s
  where s.key like 'home\_%'
     or s.key like 'pdp\_%'
     or s.key like 'site\_%';

grant select on public_settings to anon, authenticated;

commit;


-- ===========================================================
-- AFTER RUNNING THIS
-- ===========================================================
-- Go to Admin → Site text → Business details and paste your ABN in.
-- The footer picks it up on the next page load. Until you do, the
-- footer reads simply "© 2026 Squishy Society" with no empty label.
-- ===========================================================


-- ===========================================================
-- CHECK THE BOUNDARY STILL HOLDS — this must return NOTHING
-- ===========================================================
--   select * from public_settings
--   where key not like 'home\_%'
--     and key not like 'pdp\_%'
--     and key not like 'site\_%';
-- ===========================================================
