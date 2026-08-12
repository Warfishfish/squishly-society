/* ===========================================================
   Squishy Society — shared admin logic
   -----------------------------------------------------------
   Loaded by every admin page. Handles:
     - creating the Supabase client
     - the auth guard (kick anonymous users to the login page)
     - the shared nav / page shell
     - small formatting + profit helpers used across pages

   Loaded as a module:
     <script type="module" src="admin.js"></script>
   =========================================================== */

import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm";

const cfg = window.SQUISHY_CONFIG || {};

export const supabase = createClient(cfg.SUPABASE_URL, cfg.SUPABASE_KEY, {
  auth: {
    persistSession: true,       // stay logged in across page loads
    autoRefreshToken: true,     // refresh silently before expiry
    storageKey: "squishy_admin_auth"
  }
});

/* ---------- money + profit ---------- */

export function money(n) {
  const v = Number(n || 0);
  return "$" + v.toFixed(2);
}

/** Landed cost = what the item actually costs us to get to a customer. */
export function landedCost(supplierCost, shippingCost) {
  return Number(supplierCost || 0) + Number(shippingCost || 0);
}

/**
 * Profit and margin for one item.
 * Kept in one place so every screen agrees, and so extra costs
 * (transaction fees, packaging) can be added here later without
 * hunting through pages.
 */
export function profitOf(price, supplierCost, shippingCost) {
  const sell = Number(price || 0);
  const cost = landedCost(supplierCost, shippingCost);
  const profit = sell - cost;
  const margin = sell > 0 ? profit / sell : 0;
  return { sell, cost, profit, margin };
}

export function pct(n) {
  return (Number(n || 0) * 100).toFixed(1) + "%";
}

/* ---------- status presentation ---------- */

export const STATUS_LABELS = {
  draft: "Draft",
  active: "Active",
  hidden: "Hidden",
  out_of_stock: "Out of stock",
  archived: "Archived",
  research: "Research"
};

export const RESEARCH_STATUS_LABELS = {
  interesting: "Interesting",
  researching: "Researching",
  testing: "Testing",
  winner: "Winner",
  rejected: "Rejected"
};

export function statusPill(status) {
  const label = STATUS_LABELS[status] || status || "—";
  return `<span class="pill pill-${status}">${label}</span>`;
}

/* ---------- auth ---------- */

/**
 * Guard every admin page. Returns the signed-in user, or redirects
 * to the login screen and never resolves.
 *
 * Note this is a convenience, not the security boundary — the real
 * protection is in the database rules. Even if someone skipped this
 * check, Supabase would refuse to return any data.
 */
export async function requireAuth() {
  const { data, error } = await supabase.auth.getSession();
  if (error || !data.session) {
    const here = window.location.pathname.split("/").pop() || "index.html";
    window.location.replace("login.html?next=" + encodeURIComponent(here));
    return new Promise(() => {}); // halt this page's execution
  }
  return data.session.user;
}

export async function signOut() {
  await supabase.auth.signOut();
  window.location.replace("login.html");
}

/* ---------- page shell ---------- */

const NAV = [
  { href: "index.html",    label: "Dashboard" },
  { href: "products.html", label: "Products" },
  { href: "research.html", label: "Research" },
  { href: "import.html",   label: "Add from URL" },
  { href: "settings.html", label: "Settings" }
];

/**
 * Renders the shared header into <div id="admin-shell">.
 * `current` is the filename to highlight.
 */
export function renderShell(current, user) {
  const el = document.getElementById("admin-shell");
  if (!el) return;

  el.innerHTML = `
    <header class="admin-header">
      <div class="admin-bar">
        <a href="index.html" class="admin-logo">Squishy Society <span>admin</span></a>
        <nav class="admin-nav">
          ${NAV.map(n => `
            <a href="${n.href}" class="${n.href === current ? "on" : ""}">${n.label}</a>
          `).join("")}
        </nav>
        <div class="admin-user">
          <span class="admin-email">${user && user.email ? user.email : ""}</span>
          <button class="btn-ghost" id="signout-btn" type="button">Sign out</button>
        </div>
      </div>
    </header>
    <div class="admin-viewlink">
      <a href="../index.html" target="_blank" rel="noopener">View shop ↗</a>
    </div>
  `;

  const btn = document.getElementById("signout-btn");
  if (btn) btn.addEventListener("click", signOut);
}

/* ---------- small UI helpers ---------- */

/** Non-blocking status message. Avoids alert() entirely. */
export function toast(message, kind = "ok") {
  let t = document.getElementById("admin-toast");
  if (!t) {
    t = document.createElement("div");
    t.id = "admin-toast";
    document.body.appendChild(t);
  }
  t.className = "admin-toast show " + kind;
  t.textContent = message;
  clearTimeout(t._timer);
  t._timer = setTimeout(() => { t.className = "admin-toast " + kind; }, 3200);
}

export function esc(s) {
  return String(s == null ? "" : s)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

/** Turn a Supabase error into something readable without leaking internals. */
export function friendlyError(error) {
  if (!error) return "Something went wrong.";
  const m = String(error.message || error);
  if (/duplicate key/i.test(m) && /sku/i.test(m)) {
    return "That SKU is already used by another product.";
  }
  if (/Invalid login credentials/i.test(m)) {
    return "That email or password isn't right.";
  }
  if (/Email not confirmed/i.test(m)) {
    return "This account still needs its email confirmed in Supabase.";
  }
  if (/Failed to fetch|NetworkError/i.test(m)) {
    return "Can't reach the database — check your internet connection.";
  }
  return m;
}
