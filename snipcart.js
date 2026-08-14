/* ===========================================================
   Squishy Society — Snipcart checkout (TEST WIRING)
   ===========================================================
   This is deliberately NOT live yet.

   Snipcart only loads, and the Snipcart buy button only appears,
   when the page URL carries ?snipcart=1 — for example:

     product.html?id=sq-076&snipcart=1

   Customers never see any of this. It exists so one real test
   purchase can be completed end to end before the existing cart
   is replaced.

   WHY TEST ONE PRODUCT FIRST
   Snipcart validates the price of everything in a cart by fetching
   the product's page and reading data-item-price off the button. Our
   pages build themselves from the database AFTER the HTML arrives,
   so that button is not in the first response a crawler sees.
   Snipcart's crawler does run JavaScript, so this should work — but
   if it doesn't, the failure lands at checkout with a "product not
   found" style error, which is the worst possible place to find out.
   Ten minutes of testing beats rewriting the cart twice.

   THE KEY BELOW IS THE PUBLIC KEY.
   It is meant to be readable in page source. The SECRET key (the one
   starting ST_) must never appear in this repo or any file in it.
   =========================================================== */

(function () {
  "use strict";

  var PUBLIC_API_KEY =
    "MGE0ZjEyMDctMWYxZi00Y2E4LWFjOTgtNGVhNmQ0MzU3YmQ2NjM5MjIzMDc2ODA2MzE4NzQ2";

  var CURRENCY = "aud";

  function enabled() {
    return new URLSearchParams(window.location.search).get("snipcart") === "1";
  }

  window.SNIPCART_TEST_MODE = enabled();

  if (!enabled()) return;

  /* ---------- load Snipcart ---------- */
  window.SnipcartSettings = {
    publicApiKey: PUBLIC_API_KEY,
    loadStrategy: "on-user-interaction",
    currency: CURRENCY,
    version: "3.0"
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

  document.addEventListener("DOMContentLoaded", function () {
    document.body.appendChild(mount);
    head.appendChild(js);
  });

  /**
   * Builds the Snipcart buy button for a product.
   *
   * data-item-url is what Snipcart fetches to verify the price. It points
   * at /snipcart-validate — a server-side helper that returns the current
   * price straight from the database (see functions/snipcart-validate.js).
   * That endpoint renders the SAME buttons this function does, so the id
   * and price Snipcart finds there match the cart line exactly.
   *
   * A variant travels as its own cart line, keyed "<sku>|<label>", with
   * the variant's absolute price — NOT as a custom field. The validation
   * helper builds its ids the same way, so the two always agree.
   *
   * @param {object} p        product record
   * @param {number} price    the price actually being charged
   * @param {string} variant  selected option label, or null
   * @param {number} qty      quantity to add, defaults to 1
   */
  window.snipcartButton = function (p, price, variant, qty) {
    var url = location.origin + "/snipcart-validate?id=" + encodeURIComponent(p.id);

    var esc = function (s) {
      return String(s == null ? "" : s)
        .replace(/&/g, "&amp;").replace(/</g, "&lt;")
        .replace(/>/g, "&gt;").replace(/"/g, "&quot;");
    };

    var itemId = variant ? p.id + "|" + variant : p.id;
    var itemName = variant ? p.name + " — " + variant : p.name;

    return '<button class="btn pdp-add snipcart-add-item"' +
      ' data-item-id="' + esc(itemId) + '"' +
      ' data-item-name="' + esc(itemName) + '"' +
      ' data-item-price="' + Number(price).toFixed(2) + '"' +
      ' data-item-url="' + esc(url) + '"' +
      ' data-item-description="' + esc((p.description || "").slice(0, 160)) + '"' +
      ' data-item-image="' + esc(p.image || "") + '"' +
      ' data-item-quantity="' + (Number(qty) || 1) + '"' +
      ' data-item-max-quantity="99"' +
      ' type="button">Buy with Snipcart (test)</button>';
  };
})();
