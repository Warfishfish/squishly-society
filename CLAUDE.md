# Squishy Society — project brief for Claude

Read this first. It's the standing context for this repo. The owner (Marcus, Melbourne)
is a **git novice** — give explicit, plain-language steps and always say clearly whether
a command goes in the **VS Code Terminal** (git) or the **Supabase website's SQL Editor**
(SQL). Never mix the two.

## What this is
A dropshipping e-commerce storefront for squishy toys. Plain **HTML / CSS / vanilla JS,
no build step, no framework, no npm**. Hosted on **Cloudflare Pages** (auto-deploys from
GitHub `main` on every push) at **squishy-society.pages.dev**. Backend is **Supabase**
(Postgres + Auth).

## How the code is wired
- `products.js` / `product-data.js` — a built-in copy of the catalogue (the offline
  fallback). Declares `PRODUCTS`, `PRODUCT_DATA`, `CATEGORY_LABELS`, `MYSTERY_IDS`,
  `NEW_DROP_IDS` with `var` (not `const`) so they can be overridden.
- `data-source.js` — fetches the live catalogue from Supabase and overwrites those
  globals. Every page reads the globals, so nothing else needs to know where the data
  came from. Use `window.whenCatalogueReady(fn)` to run after DOM + data are both ready.
- `cart.js` — the current on-site cart + pricing helpers (`money`, `unitPrice`,
  `hasVariantPricing`, `fromPrice`). Shared by shop and product pages.
- `app.js` — homepage/shop grid. `product-page.js` — the product detail page.
- `site-text.js` + `[data-text="key"]` attributes — lets admin edit on-site wording;
  falls back to the wording baked into the HTML if the DB is unreachable.
- `admin/` — the private admin (Supabase Auth). Products, drops, site-text, etc.
- `supabase/` — schema + numbered migrations. Run them in the Supabase SQL Editor, in
  number order; all are safe to run twice.

## Security model (important)
- Two Supabase keys exist. The **publishable** key (`sb_publishable_…`) is safe in
  client-side source and IS committed. The **service_role** key must NEVER appear in the
  repo or any file — it's full admin access.
- The public site reads **views** (`public_products`, `public_product_variants`,
  `public_settings`) that expose only safe columns — never supplier cost, supplier URLs,
  or internal notes. Base tables are locked down. Keep it that way.
- `public_settings` only exposes keys starting `home_`, `pdp_`, or `site_` — any new
  setting is private by default.

## Payments (Snipcart) — current state
- Snipcart checkout WORKS end-to-end but is in **Test mode** and hidden behind
  `?snipcart=1` in the URL. Real customers still use `cart.js`. Do not un-gate or switch
  to Live keys without the owner explicitly deciding to launch.
- `snipcart.js` builds the buy button; `data-item-url` points at
  `/snipcart-validate?id=<sku>`. Variants are separate cart lines keyed `<sku>|<label>`.
- `functions/snipcart-validate.js` is a **Cloudflare Pages Function** that returns the
  live price server-side (from the public views) so Snipcart can validate a
  database-driven, client-rendered catalogue. The admin stays the single source of truth
  for prices. Only the **public** Snipcart key belongs in the repo; the `ST_…` secret
  key must never be committed.

## Sourcing discipline (if adding products)
Cost from the REGULAR price, never the "Welcome deal". Always check the Specifications
**Brand Name** field — no licensed/branded IP (no NeeDoh, Pokémon, Sanrio, etc.). Many
AliExpress listings pool reviews across merchants ("aggregate listings") — note that and
name the real seller. Every image must be eyeballed before it's used.

## Workflow / gotchas
- **git → Terminal. SQL → Supabase website.** Never mix them.
- Push: `git add <files>` → `git commit -m "…"` → `git push`. Cloudflare rebuilds in
  1–2 minutes. Prefer adding specific files over `git add -A` (there's an untracked
  `.claude/` folder that shouldn't be committed).
- If git complains about `index.lock`: `rm -f .git/index.lock`.
- Anything set to `status = 'active'` is live to customers immediately — no publish step.
- Keep the offline copy in `products.js` roughly in sync when you change prices, since
  it's the fallback if Supabase is unreachable.

## What's next (Phase 3)
Convert the whole catalogue to Snipcart and retire `cart.js`; make Snipcart's checkout
"Unit Number" field optional; replace the contact-form/newsletter backend (Netlify Forms
is gone — a Cloudflare Function is the natural replacement); choose which Draft products
go Active for launch; resolve sq-073 (supplier swapped the product) and rename sq-082;
re-source photos for the 13 original products that only have 3 images.
