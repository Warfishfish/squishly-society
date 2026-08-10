/* ===========================================================
   Squishy Society — product detail page
   Reads ?id=sq-0XX from the URL and renders that product.
   =========================================================== */

function qs(name) {
  return new URLSearchParams(window.location.search).get(name);
}

function starRow(rating) {
  const full = Math.floor(rating);
  const half = rating - full >= 0.5;
  let s = "★".repeat(full);
  if (half) s += "½";
  return s;
}

function renderProductPage() {
  const id = qs("id");
  const p = findProduct(id);
  const body = document.getElementById("pdp-body");

  if (!p) {
    body.innerHTML = `
      <div class="pdp-missing">
        <h1>Product not found</h1>
        <p>We couldn't find that one. It may have sold out or been renamed.</p>
        <a href="index.html#shop" class="btn">Back to the shop</a>
      </div>`;
    return;
  }

  document.title = p.name + " — Squishy Society";
  const d = productData(p.id);
  const gallery = (d && d.gallery && d.gallery.length) ? d.gallery.slice() : [];
  if (!gallery.length || gallery[0] !== p.image) gallery.unshift(p.image);
  const uniqueGallery = [...new Set(gallery)];

  const opts = d && d.options && d.options.values && d.options.values.length ? d.options : null;
  const sup = d && d.supplier ? d.supplier : null;
  const isMystery = typeof MYSTERY_IDS !== "undefined" && MYSTERY_IDS.indexOf(p.id) !== -1;
  const isNew = typeof NEW_DROP_IDS !== "undefined" && NEW_DROP_IDS.indexOf(p.id) !== -1;

  body.innerHTML = `
    <nav class="crumbs">
      <a href="index.html">Home</a> ›
      <a href="index.html#shop">Shop</a> ›
      <a href="index.html#shop">${CATEGORY_LABELS[p.category] || p.category}</a> ›
      <span>${p.name}</span>
    </nav>

    <div class="pdp-grid">
      <div class="pdp-media">
        <div class="pdp-main">
          <img id="pdp-main-img" src="${uniqueGallery[0]}" alt="${p.name}"
               onerror="this.closest('.pdp-main').classList.add('img-missing');this.remove();">
        </div>
        ${uniqueGallery.length > 1 ? `
        <div class="pdp-thumbs">
          ${uniqueGallery.map((g, i) => `
            <button class="pdp-thumb ${i === 0 ? "active" : ""}" data-src="${g}" aria-label="View image ${i + 1}">
              <img src="${g}" alt="" onerror="this.closest('.pdp-thumb').style.display='none';">
            </button>`).join("")}
        </div>` : ""}
      </div>

      <div class="pdp-info">
        <div class="pdp-badges">
          ${isNew ? `<span class="badge badge-new">Just landed</span>` : ""}
          ${isMystery ? `<span class="badge badge-mystery">Mystery pick</span>` : ""}
          <span class="badge badge-cat">${CATEGORY_LABELS[p.category] || p.category}</span>
        </div>

        <h1>${p.name}</h1>
        <div class="pdp-price">${money(p.price)}</div>

        <p class="pdp-desc">${p.description}</p>

        ${isMystery ? `<div class="mystery-note">🎁 This one ships as a random pick — part of the fun is not knowing which you'll get.</div>` : ""}

        <form id="pdp-form">
          ${opts ? `
          <div class="pdp-field">
            <label class="pdp-label">${opts.label}</label>
            <div class="opt-row" id="opt-row">
              ${opts.values.map((v, i) => `
                <button type="button" class="opt-btn ${i === 0 ? "selected" : ""}" data-val="${v.replace(/"/g, "&quot;")}">${v}</button>`).join("")}
            </div>
          </div>` : ""}

          <div class="pdp-field">
            <label class="pdp-label" for="qty">Quantity</label>
            <div class="qty-stepper">
              <button type="button" id="qty-minus" aria-label="Decrease quantity">−</button>
              <input id="qty" type="number" min="1" max="99" value="1" inputmode="numeric">
              <button type="button" id="qty-plus" aria-label="Increase quantity">+</button>
            </div>
          </div>

          <button type="submit" class="btn pdp-add">Add to cart</button>
        </form>

        <ul class="pdp-facts">
          <li>📦 Ships Australia-wide · free over $60</li>
          <li>🕑 Dispatched in 1–3 business days, then 12–25 business days delivery</li>
          <li>↩️ 14-day change-of-mind returns · <a href="shipping-returns.html">full policy</a></li>
          <li>💬 Questions? <a href="contact.html">Send us a message</a></li>
        </ul>

        ${sup ? `
        <div class="supplier-box">
          <div class="supplier-head">
            <strong>What buyers are saying</strong>
            <span class="supplier-score">${starRow(sup.rating)} ${sup.rating.toFixed(1)}</span>
          </div>
          <p class="supplier-sub">
            ${sup.reviews.toLocaleString()} AliExpress reviews from the <em>source listing</em> we order this product from —
            not yet our own. We're a new store and haven't collected our own customer reviews here.
          </p>
          ${sup.quotes && sup.quotes.length ? `
          <div class="supplier-quotes">
            ${sup.quotes.map(q => `
              <div class="squote">
                <p>"${q.text.replace(/"/g, "&quot;")}"</p>
                <span class="squote-meta">${q.author ? q.author + " · " : ""}AliExpress buyer${q.variant ? " · " + q.variant : ""}</span>
              </div>`).join("")}
          </div>` : ""}
          ${sup.tags && sup.tags.length ? `
          <div class="supplier-tags">
            ${sup.tags.map(t => `<span class="stag">${t}</span>`).join("")}
          </div>
          <p class="supplier-foot">Themes buyers mentioned most often, shown unedited — including the critical ones.</p>` : ""}
        </div>` : ""}

        <div class="own-reviews">
          <h3>Squishy Society reviews</h3>
          <p>No reviews yet — we're new. Once you've received an order we'll email you and yours will show up here.</p>
        </div>
      </div>
    </div>`;

  /* gallery thumbs */
  body.querySelectorAll(".pdp-thumb").forEach(btn => {
    btn.addEventListener("click", () => {
      const img = document.getElementById("pdp-main-img");
      if (img) img.src = btn.dataset.src;
      body.querySelectorAll(".pdp-thumb").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
    });
  });

  /* variant selection */
  let selected = opts ? opts.values[0] : null;
  const optRow = document.getElementById("opt-row");
  if (optRow) {
    optRow.querySelectorAll(".opt-btn").forEach(b => {
      b.addEventListener("click", () => {
        optRow.querySelectorAll(".opt-btn").forEach(x => x.classList.remove("selected"));
        b.classList.add("selected");
        selected = b.dataset.val;
      });
    });
  }

  /* quantity */
  const qtyInput = document.getElementById("qty");
  document.getElementById("qty-minus").addEventListener("click", () => {
    qtyInput.value = Math.max(1, (parseInt(qtyInput.value, 10) || 1) - 1);
  });
  document.getElementById("qty-plus").addEventListener("click", () => {
    qtyInput.value = Math.min(99, (parseInt(qtyInput.value, 10) || 1) + 1);
  });

  document.getElementById("pdp-form").addEventListener("submit", e => {
    e.preventDefault();
    const q = Math.max(1, Math.min(99, parseInt(qtyInput.value, 10) || 1));
    addToCart(p.id, selected, q);
  });

  renderRelated(p);
}

function renderRelated(p) {
  const wrap = document.getElementById("related-wrap");
  const grid = document.getElementById("related");
  const others = PRODUCTS.filter(x => x.category === p.category && x.id !== p.id).slice(0, 4);
  if (!others.length) return;
  wrap.style.display = "";
  grid.innerHTML = others.map(o => `
    <a class="product-card" href="product.html?id=${o.id}">
      <div class="product-thumb"><img src="${o.image}" alt="${o.name}" loading="lazy"
        onerror="this.closest('.product-thumb').classList.add('img-missing');this.remove();"></div>
      <div class="product-info">
        <h3>${o.name}</h3>
        <div class="product-meta">${CATEGORY_LABELS[o.category] || o.category}</div>
        <div class="product-price">${money(o.price)}</div>
      </div>
    </a>`).join("");
}

document.addEventListener("DOMContentLoaded", renderProductPage);
