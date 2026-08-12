/* ===========================================================
   Squishy Society — catalogue data source
   -----------------------------------------------------------
   Loads the shop's products from the database, falling back to
   the copy baked into products.js if that fails.

   HOW THIS FITS TOGETHER
   products.js and product-data.js load first and set up the
   PRODUCTS / PRODUCT_DATA globals. This file then tries to
   replace them with live data from Supabase. Every render
   function keeps reading the same two globals, so nothing else
   in the site had to change.

   WHY A FALLBACK
   If the database is unreachable — outage, dropped wifi, a typo
   in the config — the shop still renders yesterday's catalogue
   instead of showing a customer an empty page. Prices might be
   briefly stale; an empty shop is worse.

   PRIVACY
   This reads the `public_products` view, never the products
   table. The view has no supplier costs, supplier links or
   internal notes in it at all — see supabase/schema.sql.
   =========================================================== */

(function () {
  "use strict";

  var SUPABASE_URL = "https://kxdrwdfihmqdscesglsw.supabase.co";
  var SUPABASE_KEY = "sb_publishable_YSuOYiL2n_ysvuXAtpjNJg_KYJpRCwa";

  // Give up rather than leave a customer watching a blank grid.
  var TIMEOUT_MS = 6000;

  window.CATALOGUE_SOURCE = "loading";

  function api(path) {
    var ctrl = new AbortController();
    var timer = setTimeout(function () { ctrl.abort(); }, TIMEOUT_MS);
    return fetch(SUPABASE_URL + "/rest/v1/" + path, {
      headers: { apikey: SUPABASE_KEY, Authorization: "Bearer " + SUPABASE_KEY },
      signal: ctrl.signal
    }).then(function (r) {
      clearTimeout(timer);
      if (!r.ok) throw new Error(path + " returned " + r.status);
      return r.json();
    });
  }

  /* Reshape database rows into the structures the site already expects,
     so cart.js / app.js / product-page.js keep working untouched. */
  function applyRows(rows, variantRows) {
    var products = [];
    var data = {};
    var mystery = [];
    var newDrops = [];

    // Group variants by product, cheapest-first ordering preserved.
    var byProduct = {};
    (variantRows || []).forEach(function (v) {
      (byProduct[v.product_id] = byProduct[v.product_id] || []).push(v);
    });

    rows.forEach(function (r) {
      products.push({
        id: r.sku,
        name: r.name,
        category: r.category,
        price: Number(r.price),
        image: r.image || "",
        sourceRating: r.source_rating,
        sourceOrders: r.source_orders,
        description: r.description || ""
      });

      var entry = { gallery: r.gallery || [] };

      if (r.source_rating != null || (r.source_tags && r.source_tags.length)) {
        entry.supplier = {
          rating: Number(r.source_rating),
          reviews: Number(r.source_reviews || 0),
          tags: r.source_tags || [],
          quotes: r.source_quotes || []
        };
      }

      var vs = (byProduct[r.id] || []).sort(function (a, b) {
        return (a.sort_order || 0) - (b.sort_order || 0);
      });

      if (vs.length) {
        var values = [];
        var prices = {};
        vs.forEach(function (v) {
          values.push(v.label);
          prices[v.label] = Number(v.price);
        });
        entry.options = {
          label: r.variant_label || "Option",
          values: values,
          // variantCost is deliberately absent — the shop never needs
          // our cost, and the public view doesn't expose it anyway.
          prices: prices
        };
      }

      data[r.sku] = entry;

      if (r.is_mystery) mystery.push(r.sku);
      if (r.is_new_drop) newDrops.push(r.sku);
    });

    // These are declared with `var` in products.js / product-data.js
    // precisely so they can be swapped out here.
    PRODUCTS = products;
    PRODUCT_DATA = data;
    MYSTERY_IDS = mystery;
    NEW_DROP_IDS = newDrops;
  }

  var loaded = Promise.all([
    api("public_products?select=*&order=sort_order.asc"),
    api("public_product_variants?select=*")
  ]).then(function (res) {
    var rows = res[0];
    // An empty result means something is wrong upstream (nothing set to
    // Active, or a broken view). Keeping the built-in copy beats
    // showing a customer an empty shop.
    if (!rows || !rows.length) throw new Error("no active products returned");
    applyRows(rows, res[1]);
    window.CATALOGUE_SOURCE = "database";
  }).catch(function (err) {
    window.CATALOGUE_SOURCE = "fallback";
    // Logged, not shown — a customer shouldn't see infrastructure noise.
    if (window.console && console.warn) {
      console.warn("[Squishy] Using the built-in catalogue.", err && err.message);
    }
  });

  var domReady = new Promise(function (resolve) {
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", resolve);
    } else {
      resolve();
    }
  });

  /* Pages call this instead of listening for DOMContentLoaded, so they
     render once the data AND the DOM are both ready. */
  window.whenCatalogueReady = function (fn) {
    return Promise.all([loaded, domReady]).then(function () { fn(); });
  };
})();
