/* ===========================================================
   Squishy Society — site logic
   Cart state lives in memory (resets on page refresh). Once you
   connect a real checkout provider (see README), that provider
   takes over cart + payment handling and this file gets simpler.
   =========================================================== */

let cart = []; // [{ id, qty }]
let activeFilter = "all";

const grid = document.getElementById("product-grid");
const filtersEl = document.getElementById("filters");
const cartOverlay = document.getElementById("cart-overlay");
const cartItemsEl = document.getElementById("cart-items");
const cartCountEl = document.getElementById("cart-count");
const cartSubtotalEl = document.getElementById("cart-subtotal");
const modalOverlay = document.getElementById("modal-overlay");
const modalBody = document.getElementById("modal-body");

function money(n) {
  return "$" + n.toFixed(2) + " AUD";
}

function findProduct(id) {
  return PRODUCTS.find(p => p.id === id);
}

/* ---------- Rendering products ---------- */
function renderFilters() {
  const cats = ["all", ...new Set(PRODUCTS.map(p => p.category))];
  filtersEl.innerHTML = cats.map(c => `
    <button class="filter-btn ${c === activeFilter ? "active" : ""}" data-cat="${c}">
      ${CATEGORY_LABELS[c] || c}
    </button>
  `).join("");

  filtersEl.querySelectorAll(".filter-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      activeFilter = btn.dataset.cat;
      renderFilters();
      renderProducts();
    });
  });
}

function renderProducts() {
  const list = activeFilter === "all"
    ? PRODUCTS
    : PRODUCTS.filter(p => p.category === activeFilter);

  grid.innerHTML = list.map(p => `
    <div class="product-card" data-id="${p.id}">
      <div class="product-thumb"><img src="${p.image}" alt="${p.name}" loading="lazy" onerror="this.closest('.product-thumb').classList.add('img-missing');this.remove();"></div>
      <div class="product-info">
        <h3>${p.name}</h3>
        <div class="product-meta">${CATEGORY_LABELS[p.category] || p.category}</div>
        <div class="product-price">
          ${money(p.price)}
          <button class="add-btn" data-add="${p.id}" title="Add to cart">+</button>
        </div>
      </div>
    </div>
  `).join("");

  grid.querySelectorAll(".product-card").forEach(card => {
    card.addEventListener("click", (e) => {
      if (e.target.closest(".add-btn")) return;
      openModal(card.dataset.id);
    });
  });

  grid.querySelectorAll("[data-add]").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      addToCart(btn.dataset.add);
    });
  });
}

/* ---------- Product modal ---------- */
function openModal(id) {
  const p = findProduct(id);
  if (!p) return;
  modalBody.innerHTML = `
    <div class="modal-thumb"><img src="${p.image}" alt="${p.name}" onerror="this.closest('.modal-thumb').classList.add('img-missing');this.remove();"></div>
    <h2>${p.name}</h2>
    <div class="product-price">${money(p.price)}</div>
    <p class="desc">${p.description}</p>
    <div class="source-note">Sourced listing rating: ${p.sourceRating} ★ · ${p.sourceOrders} sold</div>
    <button class="btn" data-add="${p.id}">Add to cart</button>
  `;
  modalBody.querySelector("[data-add]").addEventListener("click", () => {
    addToCart(p.id);
    closeModal();
  });
  modalOverlay.classList.add("open");
}

function closeModal() {
  modalOverlay.classList.remove("open");
}

document.getElementById("modal-close").addEventListener("click", closeModal);
modalOverlay.addEventListener("click", (e) => {
  if (e.target === modalOverlay) closeModal();
});

/* ---------- Cart logic ---------- */
function addToCart(id) {
  const existing = cart.find(i => i.id === id);
  if (existing) existing.qty += 1;
  else cart.push({ id, qty: 1 });
  renderCart();
  openCart();
}

function changeQty(id, delta) {
  const item = cart.find(i => i.id === id);
  if (!item) return;
  item.qty += delta;
  if (item.qty <= 0) cart = cart.filter(i => i.id !== id);
  renderCart();
}

function removeFromCart(id) {
  cart = cart.filter(i => i.id !== id);
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
  const { count, subtotal } = cartTotals();
  cartCountEl.textContent = count;
  cartCountEl.style.display = count > 0 ? "flex" : "none";

  if (cart.length === 0) {
    cartItemsEl.innerHTML = `<div class="empty-cart">Your cart is empty.<br>Go squish some options 🧸</div>`;
  } else {
    cartItemsEl.innerHTML = cart.map(i => {
      const p = findProduct(i.id);
      if (!p) return "";
      return `
        <div class="cart-item">
          <div class="cart-item-thumb"><img src="${p.image}" alt="${p.name}" onerror="this.closest('.cart-item-thumb').classList.add('img-missing');this.remove();"></div>
          <div class="cart-item-info">
            <div class="name">${p.name}</div>
            <div class="qty-row">
              <button class="qty-btn" data-dec="${p.id}">−</button>
              <span>${i.qty}</span>
              <button class="qty-btn" data-inc="${p.id}">+</button>
              <button class="remove-btn" data-remove="${p.id}">Remove</button>
            </div>
          </div>
          <div>${money(p.price * i.qty)}</div>
        </div>
      `;
    }).join("");

    cartItemsEl.querySelectorAll("[data-inc]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.inc, 1)));
    cartItemsEl.querySelectorAll("[data-dec]").forEach(b => b.addEventListener("click", () => changeQty(b.dataset.dec, -1)));
    cartItemsEl.querySelectorAll("[data-remove]").forEach(b => b.addEventListener("click", () => removeFromCart(b.dataset.remove)));
  }

  cartSubtotalEl.textContent = money(subtotal);
}

function openCart() { cartOverlay.classList.add("open"); }
function closeCart() { cartOverlay.classList.remove("open"); }

document.getElementById("cart-btn").addEventListener("click", openCart);
document.getElementById("cart-close").addEventListener("click", closeCart);
cartOverlay.addEventListener("click", (e) => {
  if (e.target === cartOverlay) closeCart();
});

document.getElementById("checkout-btn").addEventListener("click", () => {
  const { count } = cartTotals();
  if (count === 0) return;
  alert(
    "This is a demo cart, so there's no real payment wired up yet.\n\n" +
    "To take real orders and payments, connect a checkout provider " +
    "(Snipcart, Stripe Payment Links, or a Shopify Buy Button) — " +
    "see the README that came with this site for step-by-step setup."
  );
});

/* ---------- Newsletter (demo only) ---------- */
const newsletterForm = document.getElementById("newsletter-form");
if (newsletterForm) {
  newsletterForm.addEventListener("submit", (e) => {
    e.preventDefault();
    alert("Thanks for signing up! (This form isn't connected to an email tool yet — see README.)");
    newsletterForm.reset();
  });
}

/* ---------- Init ---------- */
renderFilters();
renderProducts();
renderCart();
