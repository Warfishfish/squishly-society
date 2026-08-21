/* ===========================================================
   TEMPORARY DIAGNOSTIC — DELETE ONCE CHECKOUT WORKS
   -----------------------------------------------------------
   Reports which environment variable NAMES the Cloudflare
   function can see, and whether STRIPE_SECRET_KEY is among
   them. It never returns a variable's value.

   This exists because checkout kept reporting the key as
   missing while the dashboard appeared to show it set, and
   guessing at the dashboard was slower than asking the
   running code directly.

   Remove this file the moment checkout succeeds:
       git rm functions/env-check.js
   =========================================================== */

export function onRequestGet(context) {
  const env = context.env || {};
  const names = Object.keys(env).sort();
  const key = env.STRIPE_SECRET_KEY;

  const body = {
    variableNamesVisible: names,
    stripeSecretKeyPresent: typeof key === "string" && key.length > 0,
    // Shape only — enough to catch a live/test mix-up or a pasted
    // fragment, without revealing the key itself.
    looksLikeStripeSecret: typeof key === "string" ? /^sk_(test|live)_/.test(key) : false,
    mode: typeof key === "string"
      ? (key.startsWith("sk_live_") ? "LIVE" : key.startsWith("sk_test_") ? "test" : "unrecognised")
      : null,
    length: typeof key === "string" ? key.length : 0
  };

  return new Response(JSON.stringify(body, null, 2), {
    headers: { "Content-Type": "application/json", "Cache-Control": "no-store" }
  });
}
