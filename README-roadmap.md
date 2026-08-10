# Squishy Society — Setup Roadmap

This is your step-by-step guide from "prototype on my laptop" to "real store taking orders." Work through it roughly in order — later steps depend on earlier ones.

Quick disclaimer up front: I'm not a lawyer or accountant, and the legal/tax notes below are general information, not advice for your specific situation. Where it matters (ABN, GST, consumer law), the guide tells you where to go to confirm the details.

---

## 0. What you've got right now

A working front-end prototype in this folder:

- `index.html` — homepage + shop, with a product grid, filters, product detail popups, and a working shopping cart
- `about.html`, `shipping-returns.html`, `privacy.html` — policy page templates (marked with ⚠️ where you need to fill in real details)
- `products.js` — your product catalogue (currently 12 placeholder squishies with emoji "photos")
- `styles.css` — all the styling, in one file, with colors defined at the top so you can re-theme easily
- `app.js` — the logic (cart, filters, popups)

Open `index.html` in a browser right now (double-click it) and it works — you can browse, filter, add to cart, adjust quantities. What it **can't** do yet is take a real payment or actually place a supplier order — that's what the rest of this guide sets up.

---

## 1. Branding

I named the placeholder store "Squishy Society." Some other options if you want to swap: **SquishBox Co.**, **Squishly**, **The Squish Society**, **MochiMob**, **SquishNation**, **Plump & Squish**.

To rename, find-and-replace "Squishy Society" across the HTML files and update the 🧸 logo text in each page's header.

For the domain: you don't need to buy it yet (see step 4 — you're deploying to a free Netlify address first and connecting a real domain right before launch). It's still worth doing a quick availability check on a registrar now though, so you're not attached to a name that turns out to be taken — **Namecheap**, **Crazy Domains**, or **VentraIP** are common choices for `.com.au` and `.com` domains in Australia. A `.com.au` domain requires an ABN, which you've already got.

---

## 2. Editing the site

You're using VS Code, so:

1. Open this whole `squishy-society-site` folder as a project in VS Code.
2. Install the **Live Server** extension — it lets you right-click `index.html` → "Open with Live Server" and see live changes in your browser as you edit.
3. Product edits happen in `products.js` — each product is a plain object with a name, price, category, description, and placeholder emoji. Swap `emoji: "🐻"` for a real image once you're ready (see step 6).
4. If you want AI help writing/editing the code directly inside VS Code (rather than coming back to this chat each time), two common options: **GitHub Copilot** (paid extension, autocompletes and chats about your open files) or the **Claude Code extension for VS Code** (chat with Claude directly in the editor, with full access to edit these files). Neither is required — you can also keep bringing changes back here and I'll hand you updated files.

---

## 3. Register your business (Australia)

✅ **Done** — you already have an ABN, so most of this section is just for reference later (e.g. if you outgrow sole trader, or hit the GST threshold).

1. **ABN (Australian Business Number)** — free to register at [abr.gov.au](https://www.abr.gov.au). You'll want this before opening a business bank account or a payment processor account. Sole trader is the simplest structure to start with; you can restructure later if the business grows.
2. **Business name** — if you're not trading under your own personal legal name, register the business name (e.g. "Squishy Society") via the same ABR process, linked through ASIC.
3. **GST** — registration is compulsory once your turnover passes **$75,000/year**; below that it's optional. Note: once you *are* registered, GST applies to all your sales, including low-value imported goods — this is different from the old rule where anything under $1,000 landed GST-free. If you're near the threshold or unsure, a quick chat with an accountant (even a one-off session) is worth it before you scale up.
4. Keep this loose — a lot of people start as an unregistered sole trader, get the ABN sorted, and only worry about GST once sales pick up. Don't let this step block you from launching a small test store.

---

## 4. Hosting the site (GitHub + Netlify)

Since you're already using GitHub, use the **GitHub-connected** method rather than manually uploading files — it means every time you push a change to GitHub, your live site updates automatically within a minute or two, no manual re-upload ever again. This step gets you a real, working, shareable link — just not your own domain yet.

1. On GitHub, create a new **repository** (a project's home online) — e.g. `squishy-society-site`. Public or private both work fine for a plain front-end site like this since there are no secret keys stored in it.
2. Clone it to your computer (VS Code's Source Control panel → "Clone Repository", or `git clone <url>` in a terminal) — this gives you an empty local folder linked to that GitHub repo.
3. Copy all the files from this prototype (`index.html`, `styles.css`, `app.js`, `products.js`, the policy pages) into that cloned folder.
4. In VS Code's Source Control panel: stage the changes, write a commit message (e.g. "Initial site"), commit, then push. This uploads your code to GitHub.
5. Create a free account at **[Netlify](https://www.netlify.com)** — sign up with your GitHub account, which makes the next step one click.
6. In Netlify: **Add new site → Import an existing project → GitHub** → pick your repository. Since this is a plain HTML site (no build step), leave the build command blank and set the publish directory to the repo's root (`/`). Deploy.

That's it — Netlify gives you a working link like `squishy-society.netlify.app` immediately. Use that for everything while you're building: testing the cart, setting up Snipcart/Stripe, showing friends. It's a fully real, working site; it just has Netlify's address instead of your own.

From here on, your workflow for any change is: edit in VS Code → commit → push → Netlify auto-publishes.

**Connecting your own domain — do this last, right before you launch for real:**

7. Buy your domain from a registrar (see step 1 above).
8. In Netlify, go to **Domain settings → Add a domain**, enter it, and Netlify shows you exactly which DNS records to add at your registrar. Usually takes effect within a few hours.
9. Netlify issues a free HTTPS certificate automatically once the domain is connected — don't skip this, browsers flag non-HTTPS checkout pages.

There's no rush on 7–9 — everything else in this guide (payments, sourcing, legal pages) works fine on the free `netlify.app` address in the meantime.

---

## 5. Taking real payments

The cart in this prototype is fully functional but **not connected to a payment processor** — right now "Checkout" just shows a message. You have two realistic options:

**Option A — Snipcart (recommended for your setup).**
Snipcart bolts a real cart + checkout onto a plain HTML site like this one, and handles payments through Stripe or PayPal under the hood. As of now it's free to test, and for production: **2% per transaction**, or a flat **$20 USD/month** if you're doing under $1,000/month in sales (whichever is cheaper for you). Setup involves adding their JS snippet and tagging each "Add to cart" button with `data-item-id`, `data-item-price`, etc. — a moderate rework of `app.js`/`index.html`, but well documented. I can help you wire this in once you're ready — just say the word.

**Option B — Stripe Payment Links.**
Simpler but less flexible: you create a payment link per product (or a small set of bundles) directly in your Stripe dashboard, no code required, and link your "buy" buttons to them. This doesn't give you a true multi-item cart experience, but it's the fastest way to start taking real money if you want to test demand before investing more setup time.

Either way, you'll need a **Stripe account** (Stripe operates in Australia, payouts in AUD) — sign up at [stripe.com](https://stripe.com), which will ask for your ABN/business details from step 3.

---

## 6. Sourcing from AliExpress (and skipping Temu)

Quick recap of why: Temu has no dropshipping program — no API, no bulk tools, and orders arrive in Temu-branded packaging with the retail price visible, which kills your branding and makes it obvious to the customer they could've bought it cheaper themselves. AliExpress, by contrast, has an actual **Dropshipping Center** built for this.

1. Use AliExpress's Dropshipping Center (inside your AliExpress account) to browse trending/best-selling items in the squishy/soft-toy category, and cross-check against supplier ratings, order counts, and reviews — avoid brand-new listings with no track record.
2. Install **[DSers](https://www.dsers.com)** (free tier available) once you're on Shopify/WooCommerce, or fulfil manually at first: when an order comes in on your site, you place the matching order on AliExpress yourself, using the customer's shipping address, and forward them the tracking number. Manual fulfillment is completely normal for a small/new store and avoids extra tooling costs while you're testing.
3. **Pricing:** a common starting formula is 3–4x your AliExpress cost to cover payment fees, ad spend, returns, and your margin. I've included a `supplierCost` field in `products.js` (not shown on the site) so you can track your real cost vs. your listed price per item as you swap in real products.
4. **Photos:** use the supplier's own product photos to start — this is completely normal practice in dropshipping. Just avoid photos with a competitor's watermark/logo on them, and rewrite the product titles/descriptions yourself rather than copy-pasting the AliExpress listing (partly for SEO, partly because AliExpress listing copy is often rough machine-translated English).

### One real risk to flag: unlicensed character squishies

A lot of squishy listings on AliExpress are unlicensed knockoffs of characters — Pokémon, Sanrio (Hello Kitty), Disney, anime characters, and so on. Reselling those exposes *you*, not just the original supplier, to trademark/copyright infringement risk, and marketplaces or payment processors can shut down accounts over it. Stick to original/generic designs (animals, food shapes, abstract mochi shapes) — which is what I used in the placeholder catalogue — rather than anything that's clearly a copy of a copyrighted character.

---

## 7. Legal pages — finish the templates

`about.html`, `shipping-returns.html`, and `privacy.html` all have ⚠️ marked sections you need to fill in with real details once you know your actual shipping times, supplier, and tools. The shipping/returns page in particular needs to be accurate under Australian Consumer Law — customers are legally entitled to a remedy (repair, replace, or refund) if a product is faulty or not as described, regardless of what your policy says, and advertised delivery times need to be realistic given AliExpress shipping (often 2–4 weeks to Australia) rather than optimistic.

---

## 8. Suggested launch order

1. ✅ ABN — already done
2. Push the site to GitHub and deploy it to Netlify's free address (step 4, points 1–6)
3. Pick 8–12 real products from AliExpress, replace the placeholder catalogue in `products.js`, swap in real photos
4. Fill in the legal page templates with real shipping times/policies (step 7)
5. Set up Stripe + connect a checkout method (step 5)
6. Soft-launch on the free `netlify.app` address to friends/family, watch how fulfillment actually goes before spending on ads
7. Once you're happy it all works end to end, buy your domain and connect it (step 4, points 7–9) — then you're properly live
8. Start building out marketing (squishies do well on TikTok/Instagram — unboxing and "satisfying squeeze" content performs particularly well for this niche)

---

## Where to get real help

- ABN / business registration: [abr.gov.au](https://www.abr.gov.au)
- Australian Consumer Law basics: [accc.gov.au](https://www.accc.gov.au)
- Tax/GST specifics for your situation: a registered Australian accountant or tax agent
- Legal review of your policies/terms: a small-business lawyer (several Australian firms offer flat-fee small business legal packages)

I can help with any of the technical steps above whenever you're ready — wiring up Snipcart, restyling the site, writing product copy for your real items, or drafting the legal page content once you know your real shipping times.
