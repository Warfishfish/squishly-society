/* ===========================================================
   Squishy Society — create a Stripe Checkout Session
   -----------------------------------------------------------
   WHAT THIS IS
   The checkout. The browser sends only *what* is in the cart
   (product id, variant, quantity). This function decides the
   money: it looks every price up in the database itself, works
   out the discount and the postage, then asks Stripe for a
   checkout page and hands back the URL.

   WHY IT'S BUILT THIS WAY
   The browser is never trusted with prices. Someone editing the
   page can change what they *ask* for, but not what they are
   charged — the amounts come from Supabase, server-side, every
   time. That also means a price edited in Admin is live at
   checkout immediately, with nothing to sync.

   THE SECRET KEY IS NOT IN THIS FILE, AND MUST NEVER BE.
   It is read from the environment (context.env.STRIPE_SECRET_KEY),
   which is set in the Cloudflare dashboard under
   Settings → Variables and Secrets. A Stripe secret key committed
   to a repo can be used by anyone to move real money.
   =========================================================== */

const SUPABASE_URL = "https://kxdrwdfihmqdscesglsw.supabase.co";
const SUPABASE_KEY = "sb_publishable_YSuOYiL2n_ysvuXAtpjNJg_KYJpRCwa";
const SB = { apikey: SUPABASE_KEY, Authorization: "Bearer " + SUPABASE_KEY };

const CURRENCY = "aud";

/* The offer, in one place. cart.js shows these numbers on the shop;
   these are the ones that actually decide what is charged. */
const DISCOUNT_PERCENT = 10;
const DISCOUNT_OVER = 75;      // dollars
const POSTAGE = 8.95;          // dollars
const FREE_POSTAGE_OVER = 75;  // dollars

/* Reused so Stripe doesn't collect a new coupon on every order. */
const COUPON_ID = "squishy-10-over-75";

const money = d => Math.round(Number(d) * 100); // dollars -> cents

/* Stripe's API takes form encoding, including nested keys like
   line_items[0][price_data][currency]. */
function formEncode(obj, prefix, out) {
  out = out || [];
  for (const key of Object.keys(obj)) {
    const val = obj[key];
    if (val === undefined || val === null) continue;
    const name = prefix ? `${prefix}[${key}]` : key;
    if (typeof val === "object") formEncode(val, name, out);
    else out.push(encodeURIComponent(name) + "=" + encodeURIComponent(String(val)));
  }
  return out;
}

async function stripe(path, secret, body) {
  const res = await fetch("https://api.stripe.com/v1/" + path, {
    method: "POST",
    headers: {
      Authorization: "Bearer " + secret,
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: body ? formEncode(body).join("&") : undefined
  });
  const json = await res.json();
  return { ok: res.ok, status: res.status, json };
}

const json = (data, status) =>
  new Response(JSON.stringify(data), {
    status: status || 200,
    headers: { "Content-Type": "application/json", "Cache-Control": "no-store" }
  });

/* Makes sure the percent-off coupon exists, creating it once if not.
   Giving it a fixed id keeps this idempotent — no coupon clutter. */
async function ensureCoupon(secret) {
  const found = await fetch("https://api.stripe.com/v1/coupons/" + COUPON_ID, {
    headers: { Authorization: "Bearer " + secret }
  });
  if (found.ok) return COUPON_ID;

  const made = await stripe("coupons", secret, {
    id: COUPON_ID,
    percent_off: DISCOUNT_PERCENT,
    duration: "once",
    name: `${DISCOUNT_PERCENT}% off orders over $${DISCOUNT_OVER}`
  });
  return made.ok ? COUPON_ID : null;
}

export async function onRequestPost(context) {
  const secret = context.env && context.env.STRIPE_SECRET_KEY;
  if (!secret) {
    // Deliberately vague to the shopper, specific in the logs.
    console.error("STRIPE_SECRET_KEY is not set in the Cloudflare environment.");
    return json({ error: "Checkout is not configured yet." }, 500);
  }

  let cart;
  try {
    const body = await context.request.json();
    cart = body && body.items;
  } catch (e) {
    return json({ error: "Could not read the cart." }, 400);
  }
  if (!Array.isArray(cart) || !cart.length) {
    return json({ error: "Your cart is empty." }, 400);
  }
  if (cart.length > 50) {
    return json({ error: "That's too many different items for one order." }, 400);
  }

  /* ---- what did they ask for? (ids and quantities only) ---- */
  const wanted = [];
  for (const raw of cart) {
    const sku = String((raw && raw.id) || "").trim();
    if (!/^[a-z0-9-]{1,40}$/i.test(sku)) {
      return json({ error: "That cart contains something we don't recognise." }, 400);
    }
    const qty = Math.max(1, Math.min(99, parseInt(raw.qty, 10) || 1));
    const variant = raw.variant ? String(raw.variant).slice(0, 80) : null;
    wanted.push({ sku, qty, variant });
  }

  /* ---- what are they actually worth? (straight from the database) ---- */
  const skus = [...new Set(wanted.map(w => w.sku))];
  let products, variants;
  try {
    const pRes = await fetch(
      `${SUPABASE_URL}/rest/v1/public_products?sku=in.(${skus.map(encodeURIComponent).join(",")})` +
      `&select=id,sku,name,price,image,description`,
      { headers: SB }
    );
    if (!pRes.ok) throw new Error("products " + pRes.status);
    products = await pRes.json();

    const ids = products.map(p => p.id);
    if (ids.length) {
      const vRes = await fetch(
        `${SUPABASE_URL}/rest/v1/public_product_variants?product_id=in.(${ids.map(encodeURIComponent).join(",")})` +
        `&select=product_id,label,price`,
        { headers: SB }
      );
      variants = vRes.ok ? await vRes.json() : [];
    } else variants = [];
  } catch (err) {
    console.error("catalogue lookup failed:", err.message);
    return json({ error: "We couldn't reach the shop just now. Please try again." }, 503);
  }

  const bySku = Object.create(null);
  products.forEach(p => { bySku[p.sku] = p; });

  const line_items = [];
  let subtotal = 0;

  for (const w of wanted) {
    const p = bySku[w.sku];
    // Not active / no longer sold — refuse rather than guess a price.
    if (!p) return json({ error: "One of those items is no longer available." }, 409);

    let unit = Number(p.price);
    let name = p.name;

    if (w.variant) {
      const v = (variants || []).find(
        x => x.product_id === p.id && String(x.label) === w.variant
      );
      if (!v) return json({ error: `That option is no longer available for ${p.name}.` }, 409);
      unit = Number(v.price);
      name = `${p.name} — ${v.label}`;
    }

    if (!(unit > 0)) return json({ error: `${p.name} isn't available to buy right now.` }, 409);

    subtotal += unit * w.qty;

    const product_data = { name };
    if (p.description) product_data.description = String(p.description).slice(0, 500);
    if (p.image && /^https?:\/\//i.test(p.image)) product_data.images = [p.image];

    line_items.push({
      price_data: { currency: CURRENCY, unit_amount: money(unit), product_data },
      quantity: w.qty
    });
  }

  /* ---- postage and discount, decided here and nowhere else ---- */
  const freePostage = subtotal >= FREE_POSTAGE_OVER;
  const postage = freePostage ? 0 : POSTAGE;

  const shipping_options = [{
    shipping_rate_data: {
      type: "fixed_amount",
      fixed_amount: { amount: money(postage), currency: CURRENCY },
      display_name: freePostage ? "Free postage" : "Standard postage",
      delivery_estimate: {
        minimum: { unit: "business_day", value: 12 },
        maximum: { unit: "business_day", value: 25 }
      }
    }
  }];

  const origin = new URL(context.request.url).origin;

  const session = {
    mode: "payment",
    line_items,
    shipping_options,
    shipping_address_collection: { allowed_countries: { 0: "AU" } },
    billing_address_collection: "auto",
    phone_number_collection: { enabled: false },
    success_url: origin + "/order-complete.html?session_id={CHECKOUT_SESSION_ID}",
    cancel_url: origin + "/index.html#shop",
    // Handy when reconciling an order against the shop later.
    metadata: {
      subtotal_aud: subtotal.toFixed(2),
      free_postage: String(freePostage)
    }
  };

  if (subtotal >= DISCOUNT_OVER) {
    const coupon = await ensureCoupon(secret);
    if (coupon) session.discounts = { 0: { coupon } };
  }

  const made = await stripe("checkout/sessions", secret, session);
  if (!made.ok) {
    console.error("Stripe rejected the session:", JSON.stringify(made.json).slice(0, 600));
    return json({ error: "We couldn't start checkout. Please try again." }, 502);
  }

  return json({ url: made.json.url });
}
