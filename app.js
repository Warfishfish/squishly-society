/* ===========================================================
   Squishy Society — homepage / shop grid
   Cart logic lives in cart.js (shared with the product pages).
   =========================================================== */

let activeFilter = "all";
let activeSort = "featured";

const grid = document.getElementById("product-grid");
const filtersEl = document.getElementById("filters");
const countEl = document.getElementById("product-count");
const sortEl = document.getElementById("sort-select");

/* ---------- Active niche ----------
   Squishy Society committed to Mochi, Prism Cubes, and Keychain as its
   focus categories. Jumbo/Animals/Food-shaped/Fidget products stay in
   products.js and product-data.js (nothing was deleted) but are hidden
   from tiles, filters, and the main shop grid — reversible if the niche
   changes later. Direct links to those product pages still work. */
const ACTIVE_CATEGORIES = ["mochi", "food", "dumpling", "animal", "mystery", "prism", "keychain"];
function nicheProducts() {
  return PRODUCTS.filter(p => ACTIVE_CATEGORIES.indexOf(p.category) !== -1);
}

/* ---------- Category tiles ---------- */
const TILE_EMOJI = {
  mochi: "🍡", jumbo: "🐣", animal: "🐱",
  food: "🍞", fidget: "🟣", keychain: "🔑", prism: "🔷",
  dumpling: "🥟", mystery: "🎁", animal: "🦆"
};

function renderTiles() {
  const row = document.getElementById("tile-row");
  if (!row) return;
  const cats = ACTIVE_CATEGORIES.filter(c => PRODUCTS.some(p => p.category === c));
  row.innerHTML = cats.map(c => {
    const n = PRODUCTS.filter(p => p.category === c).length;
    const pic = PRODUCTS.find(p => p.category === c);
    return `
      <button class="tile" data-cat="${c}">
        <span class="tile-img">
          <img src="${pic ? pic.image : ""}" alt="" loading="lazy"
               onerror="this.closest('.tile-img').classList.add('img-missing');this.remove();">
          <span class="tile-emoji">${TILE_EMOJI[c] || "🧸"}</span>
        </span>
        <span class="tile-name">${CATEGORY_LABELS[c] || c}</span>
        <span class="tile-count">${n} items</span>
      </button>`;
  }).join("");

  row.querySelectorAll(".tile").forEach(t => {
    t.addEventListener("click", () => {
      activeFilter = t.dataset.cat;
      renderFilters();
      renderProducts();
      document.getElementById("shop").scrollIntoView({ behavior: "smooth" });
    });
  });
}

/* ---------- Filters ---------- */
function renderFilters() {
  if (!filtersEl) return;
  const cats = ["all", ...ACTIVE_CATEGORIES.filter(c => PRODUCTS.some(p => p.category === c))];
  filtersEl.innerHTML = cats.map(c => `
    <button class="filter-btn ${c === activeFilter ? "active" : ""}" data-cat="${c}">
      ${CATEGORY_LABELS[c] || c}
    </button>`).join("");

  filtersEl.querySelectorAll(".filter-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      activeFilter = btn.dataset.cat;
      renderFilters();
      renderProducts();
    });
  });
}

/* ---------- Card markup (shared) ---------- */
function cardHTML(p) {
  const isNew = typeof NEW_DROP_IDS !== "undefined" && NEW_DROP_IDS.indexOf(p.id) !== -1;
  const isMystery = typeof MYSTERY_IDS !== "undefined" && MYSTERY_IDS.indexOf(p.id) !== -1;
  const d = productData(p.id);
  const nOpts = d && d.options && d.options.values ? d.options.values.length : 0;
  return `
    <a class="product-card" href="product.html?id=${p.id}">
      <div class="product-thumb">
        <img src="${p.image}" alt="${p.name}" loading="lazy"
             onerror="this.closest('.product-thumb').classList.add('img-missing');this.remove();">
        ${isNew ? `<span class="card-badge new">Just landed</span>` : ""}
        ${!isNew && isMystery ? `<span class="card-badge mystery">Mystery</span>` : ""}
      </div>
      <div class="product-info">
        <h3>${p.name}</h3>
        <div class="product-meta">
          ${CATEGORY_LABELS[p.category] || p.category}${nOpts > 1 ? ` · ${nOpts} options` : ""}
        </div>
        <div class="product-price">
          ${hasVariantPricing(p.id) ? "From " + money(fromPrice(p.id)) : money(p.price)}
          <span class="view-link">View →</span>
        </div>
      </div>
    </a>`;
}

/* ---------- Main grid ---------- */
function sortList(list) {
  const l = list.slice();
  if (activeSort === "price-asc") l.sort((a, b) => a.price - b.price);
  else if (activeSort === "price-desc") l.sort((a, b) => b.price - a.price);
  else if (activeSort === "name") l.sort((a, b) => a.name.localeCompare(b.name));
  return l;
}

function renderProducts() {
  if (!grid) return;
  const list = sortList(
    activeFilter === "all" ? nicheProducts() : nicheProducts().filter(p => p.category === activeFilter)
  );
  grid.innerHTML = list.map(cardHTML).join("");
  if (countEl) {
    countEl.textContent = list.length + (list.length === 1 ? " product" : " products");
  }
}

/* ---------- Feature rows ---------- */
function renderRow(elId, ids) {
  const el = document.getElementById(elId);
  if (!el) return;
  const items = ids
    .map(id => PRODUCTS.find(p => p.id === id))
    .filter(p => p && ACTIVE_CATEGORIES.indexOf(p.category) !== -1);
  if (!items.length) { el.closest("section").style.display = "none"; return; }
  el.innerHTML = items.map(cardHTML).join("");
}

/* ---------- Newsletter (demo) ---------- */
const newsletterForm = document.getElementById("newsletter-form");
if (newsletterForm) {
  newsletterForm.addEventListener("submit", e => {
    e.preventDefault();
    alert("Thanks! This signup form isn't connected to an email tool yet — see the README for how to hook it up.");
    newsletterForm.reset();
  });
}

/* ---------- Init ----------
   whenCatalogueReady waits for BOTH the live catalogue and the DOM,
   so the grid renders once with real prices rather than flashing the
   built-in copy first. Falls back to plain DOMContentLoaded if
   data-source.js isn't on the page. */
const onReady = window.whenCatalogueReady ||
  (fn => document.addEventListener("DOMContentLoaded", fn));

onReady(() => {
  renderTiles();
  renderFilters();
  renderProducts();
  if (typeof NEW_DROP_IDS !== "undefined") renderRow("drop-grid", NEW_DROP_IDS);
  if (typeof MYSTERY_IDS !== "undefined") renderRow("mystery-grid", MYSTERY_IDS.slice(0, 8));
  if (sortEl) {
    sortEl.addEventListener("change", () => { activeSort = sortEl.value; renderProducts(); });
  }
});
