/* ===========================================================
   Squishy Society — Snipcart checkout
   ===========================================================
   This is now the real cart for the whole shop. Snipcart loads on
   every page and handles the cart, checkout and payment.

   ---------------------------------------------------------------
   SWITCHING FROM TEST TO LIVE  (the final launch step)
   ---------------------------------------------------------------
   Right now the store runs on the TEST key: the cart shows a
   "TEST MODE" banner and only test cards work — no real money can
   move. That is deliberate, so the whole shop can be exercised
   safely before taking real orders.

   To go live:
     1. In the Snipcart dashboard, switch the toggle from TEST to LIVE.
     2. Account → API Keys → copy the LIVE *public* key.
     3. Paste it into LIVE_API_KEY below and set USE_LIVE_KEY = true.
     4. Commit and push.

   The SECRET key (starts ST_) must never appear in this repo.
   Only the public key belongs here — it is meant to be readable.
   =========================================================== */

(function () {
  "use strict";

  /* The test key. Safe, public, and only moves fake money. */
  var TEST_API_KEY =
    "MGE0ZjEyMDctMWYxZi00Y2E4LWFjOTgtNGVhNmQ0MzU3YmQ2NjM5MjIzMDc2ODA2MzE4NzQ2";

  /* Paste the LIVE public key here when ready to take real orders. */
  var LIVE_API_KEY = "";

  /* Flip to true only when LIVE_API_KEY above is filled in. */
  var USE_LIVE_KEY = false;

  var PUBLIC_API_KEY = (USE_LIVE_KEY && LIVE_API_KEY) ? LIVE_API_KEY : TEST_API_KEY;
  var CURRENCY = "aud";

  /* Kept so other scripts can tell which mode the shop is in. */
  window.SNIPCART_LIVE = !!(USE_LIVE_KEY && LIVE_API_KEY);

  window.SnipcartSettings = {
    publicApiKey: PUBLIC_API_KEY,
    loadStrategy: "on-user-interaction",
    currency: CURRENCY,
    version: "3.0",
    // Overrides the checkout address form so "Unit Number" (address2)
    // is optional instead of required — see snipcart-templates.html.
    templatesUrl: "/snipcart-templates.html"
  };

  var head = document.getElementsByTagName("head")[0];

  var css = document.createElement("link");
  css.rel = "stylesheet";
  css.href = "https://cdn.snipcart.com/themes/v3.0/default/snipcart.css";
  head.appendChild(css);

  var mount = document.createElement("div");
  mount.id = "snipcart";
  mount.setAttribute("hidden", "true");
  mount.dataset.apiKey = PUBLIC_API_KEY;
  mount.dataset.currency = CURRENCY;

  var js = document.createElement("script");
  js.src = "https://cdn.snipcart.com/themes/v3.0/default/snipcart.js";
  js.async = true;

  function boot() {
    document.body.appendChild(mount);
    head.appendChild(js);
  }
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }

  /**
   * Turns an existing button into a Snipcart "add to cart" button by
   * setting the data attributes Snipcart reads. Used instead of
   * building new markup so the shop keeps its own styling.
   *
   * data-item-url points at /snipcart-validate — a server-side helper
   * that reports the current database price (functions/snipcart-validate.js).
   * Snipcart fetches it at checkout to confirm the price hasn't been
   * tampered with. It must agree with the price set here, which is why
   * both are built from the same catalogue data.
   *
   * A variant is its own cart line, keyed "<sku>|<label>", carrying the
   * variant's absolute price — the validation helper builds its ids the
   * same way, so the two always match.
   *
   * @param {HTMLElement} btn      the button to configure
   * @param {object}      p        product record
   * @param {number}      price    price actually being charged
   * @param {string|null} variant  selected option label, or null
   * @param {number}      qty      quantity to add
   */
  window.snipcartBindButton = function (btn, p, price, variant, qty) {
    if (!btn || !p) return;

    var itemId = variant ? p.id + "|" + variant : p.id;
    var itemName = variant ? p.name + " — " + variant : p.name;

    btn.classList.add("snipcart-add-item");
    btn.setAttribute("data-item-id", itemId);
    btn.setAttribute("data-item-name", itemName);
    btn.setAttribute("data-item-price", Number(price).toFixed(2));
    btn.setAttribute("data-item-url",
      location.origin + "/snipcart-validate?id=" + encodeURIComponent(p.id));
    btn.setAttribute("data-item-description", (p.description || "").slice(0, 160));
    btn.setAttribute("data-item-image", p.image || "");
    btn.setAttribute("data-item-max-quantity", "99");
    btn.setAttribute("data-item-quantity", String(Math.max(1, qty || 1)));
  };
})();
