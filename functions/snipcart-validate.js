/* ===========================================================
   Squishy Society — Snipcart price-validation helper
   -----------------------------------------------------------
   WHAT THIS IS
   A tiny server-side endpoint that runs on Cloudflare Pages.
   Its only job: when Snipcart checks a customer's cart, it
   fetches this page for each product and reads the price off
   it. This page returns that price straight from the database,
   server-side, so Snipcart always sees the current price.

   WHY IT EXISTS
   The shop's product pages are built in the customer's browser
   from Supabase AFTER the page loads. Snipcart's price checker
   does not run that code, so it saw an empty page and refused
   every order ("product-crawling-failed"). This endpoint hands
   Snipcart the same price the cart shows, with no JavaScript to
   wait for — the single source of truth stays the database, so
   editing a price in Admin keeps checkout correct automatically.

   HOW SNIPCART USES IT
   Each Snipcart buy button on the shop carries
       data-item-url="https://<site>/snipcart-validate?id=<sku>"
   At checkout Snipcart fetches that URL and looks for a button
   whose data-item-id and data-item-price match the cart line.
   This page renders exactly those buttons for the product.

   SECURITY
   - Uses only the PUBLISHABLE Supabase key (safe in public
     source, same key the shop already ships).
   - Reads only the public_products / public_product_variants
     views — never supplier costs, notes or the service_role key.
   - The id is validated against a strict pattern before it ever
     touches a query, and everything printed is HTML-escaped.
   =========================================================== */

const SUPABASE_URL = "https://kxdrwdfihmqdscesglsw.supabase.co";
const SUPABASE_KEY = "sb_publishable_YSuOYiL2n_ysvuXAtpjNJg_KYJpRCwa";

const H = { apikey: SUPABASE_KEY, Authorization: "Bearer " + SUPABASE_KEY };

function escapeHtml(s) {
  return String(s == null ? "" : s)
    .replace(/&/g, "&amp;").replace(/</g, "&lt;")
    .replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
}

function page(status, bodyInner) {
  const body =
    "<!DOCTYPE html><html lang=\"en\"><head>" +
    "<meta charset=\"utf-8\">" +
    "<meta name=\"robots\" content=\"noindex, nofollow\">" +
    "<title>Squishy Society — price check</title>" +
    "</head><body>" + bodyInner + "</body></html>";
  return new Response(body, {
    status: status,
    headers: {
      "Content-Type": "text/html; charset=utf-8",
      // Always reflect the current database price — never a stale copy.
      "Cache-Control": "no-store",
      "X-Robots-Tag": "noindex, nofollow"
    }
  });
}

/* One Snipcart buy button. Only the attributes Snipcart validates
   against matter here (id, price, url, name); the button is never
   shown to a person, it exists purely to be crawled. */
function buttonHtml(o) {
  return (
    '<button class="snipcart-add-item"' +
    ' data-item-id="' + escapeHtml(o.id) + '"' +
    ' data-item-name="' + escapeHtml(o.name) + '"' +
    ' data-item-price="' + Number(o.price).toFixed(2) + '"' +
    ' data-item-url="' + escapeHtml(o.url) + '"' +
    ' data-item-description="' + escapeHtml((o.description || "").slice(0, 160)) + '"' +
    ' data-item-image="' + escapeHtml(o.image || "") + '"' +
    ' data-item-max-quantity="99"' +
    ' type="button">' + escapeHtml(o.name) + " — $" + Number(o.price).toFixed(2) +
    "</button>"
  );
}

export async function onRequestGet(context) {
  const url = new URL(context.request.url);
  const sku = url.searchParams.get("id") || "";

  // Strict allowlist: our SKUs look like "sq-076". Anything else is
  // rejected before it can reach a query.
  if (!/^[a-z0-9-]{1,40}$/i.test(sku)) {
    return page(400, "<p>Missing or invalid product id.</p>");
  }

  let product, variants;
  try {
    const pRes = await fetch(
      SUPABASE_URL + "/rest/v1/public_products?sku=eq." +
        encodeURIComponent(sku) +
        "&select=id,sku,name,price,image,description",
      { headers: H }
    );
    if (!pRes.ok) throw new Error("products " + pRes.status);
    const rows = await pRes.json();
    if (!Array.isArray(rows) || !rows.length) {
      // Not active / doesn't exist. Snipcart will read this as
      // "product not found", which is the correct answer.
      return page(404, "<p>No active product " + escapeHtml(sku) + ".</p>");
    }
    product = rows[0];

    const vRes = await fetch(
      SUPABASE_URL + "/rest/v1/public_product_variants?product_id=eq." +
        encodeURIComponent(product.id) +
        "&select=label,price,sort_order&order=sort_order.asc",
      { headers: H }
    );
    variants = vRes.ok ? await vRes.json() : [];
  } catch (err) {
    // If the database is briefly unreachable, tell Snipcart nothing
    // rather than a wrong price — a failed validation is recoverable,
    // a wrong charge is not.
    return page(503, "<p>Price lookup temporarily unavailable.</p>");
  }

  const selfUrl = url.origin + "/snipcart-validate?id=" + encodeURIComponent(sku);

  let buttons;
  if (Array.isArray(variants) && variants.length) {
    // Each variant is its own Snipcart line, keyed "<sku>|<label>",
    // with the variant's own absolute price. This must match exactly
    // how snipcart.js builds the button on the product page.
    buttons = variants
      .map(function (v) {
        return buttonHtml({
          id: sku + "|" + v.label,
          name: product.name + " — " + v.label,
          price: Number(v.price),
          url: selfUrl,
          image: product.image,
          description: product.description
        });
      })
      .join("\n");
  } else {
    buttons = buttonHtml({
      id: sku,
      name: product.name,
      price: Number(product.price),
      url: selfUrl,
      image: product.image,
      description: product.description
    });
  }

  return page(
    200,
    "<h1>" + escapeHtml(product.name) + "</h1>\n" + buttons
  );
}
