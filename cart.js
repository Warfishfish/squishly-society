/* ===========================================================
   Squishy Society — shared cart
   Used by every page. Cart contents persist in localStorage so
   they survive navigating between the shop and product pages.
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

/* ---------- Free shipping threshold ---------- */
const FREE_SHIPPING_OVER = 60;

/* ---------- Drawer markup, injected on every page ---------- */
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
          <button class="btn" id="checkout-btn" style="width:100%;">Checkout</button>
          <div class="snipcart-hint">Demo cart — no payment connected yet.</div>
        </div>
      </div>
    </div>`;
  document.body.appendChild(wrap.firstElementChild);

  document.getElementById("cart-close").addEventListener("click", closeCart);
  document.getElementById("cart-overlay").addEventListener("click", e => {
    if (e.target.id === "cart-overlay") closeCart();
  });
  document.getElementById("checkout-btn").addEventListener("click", () => {
    if (!cartTotals().count) return;
    alert(
      "This is a demo cart — no real payment is connected yet.\n\n" +
      "To take real orders, connect a checkout provider (Snipcart or Stripe) — " +
      "see the README that came with this site."
    );
  });
}

function addToCart(id, variant, qty) {
  qty = qty || 1;
  variant = variant || null;
  const key = id + "|" + (variant || "");
  const existing = cart.find(i => (i.id + "|" + (i.variant || "")) === key);
  if (existing) existing.qty += qty;
  else cart.push({ id, variant, qty });
  saveCart(cart);
  renderCart();
  openCart();
}

function changeQty(key, delta) {
  const item = cart.find(i => (i.id + "|" + (i.variant || "")) === key);
  if (!item) return;
  item.qty += delta;
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
    subtotal += p.price * i.qty;
  });
  return { count, subtotal };
}

function renderCart() {
  const countEl = document.getElementById("cart-count");
  const itemsEl = document.getElementById("cart-items");
  const subEl = document.getElementById("cart-subtotal");
  const meter = document.getElementById("ship-meter");
  if (!itemsEl) return;

  const { count, subtotal } = cartTotals();
  if (countEl) {
    countEl.textContent = count;
    countEl.style.display = count > 0 ? "flex" : "none";
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
          <div>${money(p.price * i.qty)}</div>
        </div>`;
    }).join("");

    itemsEl.querySelectorAll("[data-inc]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.inc, 1)));
    itemsEl.querySelectorAll("[data-dec]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.dec, -1)));
    itemsEl.querySelectorAll("[data-remove]").forEach(b => b.addEventListener("click", () => removeFromCart(b.dataset.remove)));
  }

  if (subEl) subEl.textContent = money(subtotal);

  if (meter) {
    if (!cart.length) { meter.innerHTML = ""; }
    else if (subtotal >= FREE_SHIPPING_OVER) {
      meter.innerHTML = `<div class="ship-msg done">🎉 You've unlocked free shipping</div>`;
    } else {
      const left = FREE_SHIPPING_OVER - subtotal;
      const pct = Math.min(100, (subtotal / FREE_SHIPPING_OVER) * 100);
      meter.innerHTML = `
        <div class="ship-msg">${money(left)} away from free shipping</div>
        <div class="ship-bar"><span style="width:${pct}%"></span></div>`;
    }
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
