/* ===========================================================
   Squishy Society — catalogue helpers + cart button
   ===========================================================
   The cart itself is Snipcart (see snipcart.js). This file keeps
   the shared pricing helpers every page uses, points the header
   Cart button at Snipcart's cart, and keeps the little count
   bubble on that button in sync.

   The old hand-built cart drawer used to live here. It was
   removed when Snipcart went in — it could display a cart but
   could never take a payment, so keeping both would have meant
   two carts that disagree with each other.
   =========================================================== */

function money(n) { return "$" + Number(n).toFixed(2) + " AUD"; }

function findProduct(id) { return PRODUCTS.find(p => p.id === id); }

function productData(id) {
  return (typeof PRODUCT_DATA !== "undefined" && PRODUCT_DATA[id]) || null;
}

/* Some products (e.g. multi-size prism cubes) price differently per variant.
   Falls back to the flat product price when no per-variant price is set. */
function unitPrice(id, variant) {
  const p = findProduct(id);
  if (!p) return 0;
  const d = productData(id);
  if (d && d.options && d.options.prices && variant && d.options.prices[variant] != null) {
    return d.options.prices[variant];
  }
  return p.price;
}

/* Lowest price across variants, for "From $X" display on cards. Returns
   the flat product price when the product has no per-variant pricing. */
function fromPrice(id) {
  const p = findProduct(id);
  if (!p) return 0;
  const d = productData(id);
  if (d && d.options && d.options.prices) {
    const vals = Object.values(d.options.prices);
    if (vals.length) return Math.min(...vals);
  }
  return p.price;
}

function hasVariantPricing(id) {
  const d = productData(id);
  return !!(d && d.options && d.options.prices && Object.keys(d.options.prices).length > 1);
}

/* Shown on product pages. Snipcart works out real shipping at
   checkout; this is the promise made in the site copy. */
const FREE_SHIPPING_OVER = 60;

/* ---------- header cart button ---------- */

function setCartCount(n) {
  const el = document.getElementById("cart-count");
  if (!el) return;
  el.textContent = n;
  el.style.display = n > 0 ? "flex" : "none";
}

document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("cart-btn");
  if (btn) {
    /* Snipcart opens its cart for anything carrying this class, so no
       click handler of our own is needed. */
    btn.classList.add("snipcart-checkout");
  }
  setCartCount(0);

  const y = document.getElementById("year");
  if (y) y.textContent = new Date().getFullYear();
});

/* Snipcart tells us when the cart changes; mirror its count onto our
   own button so the header badge stays truthful. */
document.addEventListener("snipcart.ready", () => {
  const read = () => {
    try {
      const s = Snipcart.store.getState();
      return (s && s.cart && s.cart.items && s.cart.items.count) || 0;
    } catch (e) { return 0; }
  };
  setCartCount(read());
  try { Snipcart.store.subscribe(() => setCartCount(read())); } catch (e) {}
});
