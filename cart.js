/* ===========================================================
   Squishy Society — cart
   ===========================================================
   The cart lives here in the browser (so it survives moving
   between pages), but it only ever holds *what* you picked:
   product id, option, quantity. Never a price.

   When you check out, that list is posted to /create-checkout,
   which looks the prices up in the database, works out the
   discount and postage, and hands back a Stripe payment page.
   Prices shown here are for display; the ones you're charged
   are decided on the server. See functions/create-checkout.js.
   =========================================================== */

const CART_KEY = "squishy_cart_v1";

function loadCart() {
  try { return JSON.parse(localStorage.getItem(CART_KEY)) || []; }
  catch (e) { return []; }
}
function saveCart(c) {
  try { localStorage.setItem(CART_KEY, JSON.stringify(c)); } catch (e) {}
}

let cart = loadCart();

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

/* Lowest price across variants, for "From $X" display on cards. */
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

/* The offer, as shown to shoppers. These numbers are mirrored in
   functions/create-checkout.js, which is what actually charges.
   Change one, change the other. */
const DISCOUNT_PERCENT = 10;
const DISCOUNT_OVER = 75;
const POSTAGE = 8.95;

/* ---------- drawer markup, injected on every page ---------- */
function injectCartMarkup() {
  if (document.getElementById("cart-overlay")) return;
  const wrap = document.createElement("div");
  wrap.innerHTML = `
    <div class="cart-overlay" id="cart-overlay">
      <div class="cart-drawer">
        <div class="cart-head">
          <h3>Your Cart</h3>
          <button class="modal-close" id="cart-close" aria-label="Close cart">✕</button>
        </div>
        <div class="ship-meter" id="ship-meter"></div>
        <div class="cart-items" id="cart-items"></div>
        <div class="cart-foot">
          <div class="cart-subtotal">
            <span>Subtotal</span>
            <span id="cart-subtotal">$0.00 AUD</span>
          </div>
          <div id="cart-extras"></div>
          <button class="btn" id="checkout-btn" style="width:100%;">Checkout</button>
          <div class="snipcart-hint" id="cart-msg">Postage is worked out at checkout.</div>
        </div>
      </div>
    </div>`;
  document.body.appendChild(wrap.firstElementChild);

  document.getElementById("cart-close").addEventListener("click", closeCart);
  document.getElementById("cart-overlay").addEventListener("click", e => {
    if (e.target.id === "cart-overlay") closeCart();
  });
  document.getElementById("checkout-btn").addEventListener("click", startCheckout);
}

function addToCart(id, variant, qty) {
  qty = qty || 1;
  variant = variant || null;
  const key = id + "|" + (variant || "");
  const existing = cart.find(i => (i.id + "|" + (i.variant || "")) === key);
  if (existing) existing.qty = Math.min(99, existing.qty + qty);
  else cart.push({ id, variant, qty });
  saveCart(cart);
  renderCart();
  openCart();
}

function changeQty(key, delta) {
  const item = cart.find(i => (i.id + "|" + (i.variant || "")) === key);
  if (!item) return;
  item.qty = Math.min(99, item.qty + delta);
  if (item.qty <= 0) cart = cart.filter(i => i !== item);
  saveCart(cart);
  renderCart();
}

function removeFromCart(key) {
  cart = cart.filter(i => (i.id + "|" + (i.variant || "")) !== key);
  saveCart(cart);
  renderCart();
}

function cartTotals() {
  let count = 0, subtotal = 0;
  cart.forEach(i => {
    const p = findProduct(i.id);
    if (!p) return;
    count += i.qty;
    subtotal += unitPrice(i.id, i.variant) * i.qty;
  });
  const qualifies = subtotal >= DISCOUNT_OVER;
  const discount = qualifies ? subtotal * (DISCOUNT_PERCENT / 100) : 0;
  const postage = qualifies ? 0 : POSTAGE;
  return { count, subtotal, qualifies, discount, postage, total: subtotal - discount + postage };
}

function renderCart() {
  const countEl = document.getElementById("cart-count");
  const itemsEl = document.getElementById("cart-items");
  const subEl = document.getElementById("cart-subtotal");
  const extrasEl = document.getElementById("cart-extras");
  const meter = document.getElementById("ship-meter");
  if (!itemsEl) return;

  const t = cartTotals();
  if (countEl) {
    countEl.textContent = t.count;
    countEl.style.display = t.count > 0 ? "flex" : "none";
  }

  if (!cart.length) {
    itemsEl.innerHTML = `<div class="empty-cart">Your cart is empty.<br>Go squish some options 🧸</div>`;
  } else {
    itemsEl.innerHTML = cart.map(i => {
      const p = findProduct(i.id);
      if (!p) return "";
      const key = i.id + "|" + (i.variant || "");
      return `
        <div class="cart-item">
          <div class="cart-item-thumb"><img src="${p.image}" alt="${p.name}" onerror="this.closest('.cart-item-thumb').classList.add('img-missing');this.remove();"></div>
          <div class="cart-item-info">
            <div class="name">${p.name}</div>
            ${i.variant ? `<div class="variant-line">${i.variant}</div>` : ""}
            <div class="qty-row">
              <button class="qty-btn" data-dec="${key}" aria-label="Decrease">−</button>
              <span>${i.qty}</span>
              <button class="qty-btn" data-inc="${key}" aria-label="Increase">+</button>
              <button class="remove-btn" data-remove="${key}">Remove</button>
            </div>
          </div>
          <div>${money(unitPrice(i.id, i.variant) * i.qty)}</div>
        </div>`;
    }).join("");

    itemsEl.querySelectorAll("[data-inc]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.inc, 1)));
    itemsEl.querySelectorAll("[data-dec]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.dec, -1)));
    itemsEl.querySelectorAll("[data-remove]").forEach(b => b.addEventListener("click", () => removeFromCart(b.dataset.remove)));
  }

  if (subEl) subEl.textContent = money(t.subtotal);

  /* Show the discount and postage the moment they apply, so the total
     at checkout is never a surprise. */
  if (extrasEl) {
    extrasEl.innerHTML = !cart.length ? "" : `
      ${t.qualifies ? `
        <div class="cart-subtotal"><span>${DISCOUNT_PERCENT}% off</span><span>−${money(t.discount)}</span></div>` : ""}
      <div class="cart-subtotal">
        <span>Postage</span>
        <span>${t.postage === 0 ? "Free" : money(t.postage)}</span>
      </div>
      <div class="cart-subtotal" style="font-weight:700;"><span>Total</span><span>${money(t.total)}</span></div>`;
  }

  if (meter) {
    if (!cart.length) { meter.innerHTML = ""; }
    else if (t.qualifies) {
      meter.innerHTML = `<div class="ship-msg done">🎉 ${DISCOUNT_PERCENT}% off and free postage unlocked</div>`;
    } else {
      const left = DISCOUNT_OVER - t.subtotal;
      const pct = Math.min(100, (t.subtotal / DISCOUNT_OVER) * 100);
      meter.innerHTML = `
        <div class="ship-msg">${money(left)} away from ${DISCOUNT_PERCENT}% off and free postage</div>
        <div class="ship-bar"><span style="width:${pct}%"></span></div>`;
    }
  }
}

/* ---------- checkout ---------- */
async function startCheckout() {
  const btn = document.getElementById("checkout-btn");
  const msg = document.getElementById("cart-msg");
  if (!cart.length) return;

  btn.disabled = true;
  btn.textContent = "Taking you to payment…";
  if (msg) msg.textContent = "";

  try {
    const res = await fetch("/create-checkout", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      // Only what was chosen — the server decides every amount.
      body: JSON.stringify({
        items: cart.map(i => ({ id: i.id, variant: i.variant, qty: i.qty }))
      })
    });
    const data = await res.json().catch(() => ({}));

    if (!res.ok || !data.url) {
      btn.disabled = false;
      btn.textContent = "Checkout";
      if (msg) msg.textContent = data.error || "Something went wrong. Please try again.";
      return;
    }
    window.location.href = data.url;
  } catch (e) {
    btn.disabled = false;
    btn.textContent = "Checkout";
    if (msg) msg.textContent = "We couldn't reach checkout. Check your connection and try again.";
  }
}

function openCart() { const o = document.getElementById("cart-overlay"); if (o) o.classList.add("open"); }
function closeCart() { const o = document.getElementById("cart-overlay"); if (o) o.classList.remove("open"); }

document.addEventListener("DOMContentLoaded", () => {
  injectCartMarkup();
  const btn = document.getElementById("cart-btn");
  if (btn) btn.addEventListener("click", openCart);
  renderCart();
  const y = document.getElementById("year");
  if (y) y.textContent = new Date().getFullYear();
});
