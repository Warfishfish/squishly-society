/* ===========================================================
   Squishy Society — editable site text
   ===========================================================
   Pulls wording set in Admin → Site text and drops it into any
   element carrying a data-text="key" attribute.

   The wording written into the HTML is the fallback. If the
   database is unreachable, a key has never been set, or the box
   was cleared in the admin, the page keeps whatever is already
   in the markup — so the shop can never render blank.

   Loaded before app.js / product-page.js. Also used by the admin
   itself, which is why it guards against a missing config.
   =========================================================== */

(function () {
  window.SITE_TEXT = window.SITE_TEXT || {};

  /**
   * Applies stored wording to every [data-text] element inside `root`.
   * Safe to call repeatedly — pages that render markup after load
   * (the product page) call it again once their HTML exists.
   */
  window.applySiteText = function (root) {
    const scope = root || document;
    scope.querySelectorAll("[data-text]").forEach(el => {
      const v = window.SITE_TEXT[el.getAttribute("data-text")];
      if (typeof v === "string" && v.trim() !== "") el.textContent = v;
    });

    /* An element marked data-hide-empty disappears entirely when the
       [data-text] inside it has no value. Used for the ABN in the
       footer: rather than printing a bare "· ABN", the whole fragment
       vanishes until a real number is saved in Admin → Site text. */
    scope.querySelectorAll("[data-hide-empty]").forEach(el => {
      const target = el.matches("[data-text]") ? el : el.querySelector("[data-text]");
      const filled = target && target.textContent.trim() !== "";
      el.style.display = filled ? "" : "none";
    });
  };

  /** Look up one key, falling back to the wording passed in. */
  window.siteText = function (key, fallback) {
    const v = window.SITE_TEXT[key];
    return (typeof v === "string" && v.trim() !== "") ? v : fallback;
  };

  /* The admin loads its credentials from admin/config.js; the public
     pages don't, so the same publishable key is inlined here as a
     fallback — exactly as data-source.js does. It is the anon-equivalent
     key and is safe in public source. The service_role key must never
     appear in any file in this repo. */
  const cfg = window.SQUISHY_CONFIG || {
    SUPABASE_URL: "https://kxdrwdfihmqdscesglsw.supabase.co",
    SUPABASE_KEY: "sb_publishable_YSuOYiL2n_ysvuXAtpjNJg_KYJpRCwa"
  };

  if (!cfg.SUPABASE_URL || !cfg.SUPABASE_KEY) {
    window.SITE_TEXT_READY = Promise.resolve(window.SITE_TEXT);
    return;
  }

  /* public_settings is a view exposing only the site-text rows to
     anonymous visitors. The settings table itself stays locked to
     signed-in admins. */
  const url = cfg.SUPABASE_URL.replace(/\/$/, "") +
    "/rest/v1/public_settings?select=key,value";

  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), 6000);

  window.SITE_TEXT_READY = fetch(url, {
    headers: { apikey: cfg.SUPABASE_KEY, Authorization: "Bearer " + cfg.SUPABASE_KEY },
    signal: ctrl.signal
  })
    .then(r => (r.ok ? r.json() : Promise.reject(new Error("HTTP " + r.status))))
    .then(rows => {
      (rows || []).forEach(r => {
        if (r && r.key && typeof r.value === "string") window.SITE_TEXT[r.key] = r.value;
      });
      window.applySiteText();
      return window.SITE_TEXT;
    })
    .catch(err => {
      // Never surface this to a customer — the built-in wording is fine.
      console.warn("[site-text] using built-in wording:", err.message);
      return window.SITE_TEXT;
    })
    .finally(() => clearTimeout(timer));

  document.addEventListener("DOMContentLoaded", () => window.applySiteText());
})();
