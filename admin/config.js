/* ===========================================================
   Squishy Society — admin configuration
   -----------------------------------------------------------
   These two values are SAFE to commit to GitHub.

   The publishable key is designed to be public — it identifies
   the project, it does not grant access. What actually protects
   your data is the security rules in supabase/schema.sql:
   anonymous visitors are blocked from the products table
   entirely, and can only read the trimmed-down public view that
   excludes your costs, supplier links and private notes.

   NEVER put the `service_role` / secret key in this file. That
   one bypasses every security rule. It belongs only in server
   environment variables, never in the browser.
   =========================================================== */

window.SQUISHY_CONFIG = {
  SUPABASE_URL: "https://kxdrwdfihmqdscesglsw.supabase.co",
  SUPABASE_KEY: "sb_publishable_YSuOYiL2n_ysvuXAtpjNJg_KYJpRCwa"
};
