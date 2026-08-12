# Admin setup — one time only

Four steps, about ten minutes. Do them in order.

---

## 1. Create the database tables

1. Open your Supabase project → **SQL Editor** (left sidebar) → **New query**
2. Open `supabase/schema.sql` in VS Code, select all, copy
3. Paste into the Supabase query box → click **Run**

You should see *"Success. No rows returned."* Some grey `NOTICE` lines are normal — they just mean
"there was nothing here to replace yet".

---

## 2. Load your existing 13 products

1. Still in the SQL Editor → **New query**
2. Open `supabase/seed.sql`, select all, copy, paste, **Run**

To check it worked: left sidebar → **Table Editor** → `products`. You should see 13 rows.

> If you ever change products.js by hand again, you can regenerate this file with
> `node scripts/migrate-products.js`. It's safe to re-run in Supabase — it updates existing
> rows rather than creating duplicates.

---

## 3. Lock the door, then create your login

**This order matters.** Create your account first, *then* close signups.

1. **Authentication** → **Users** → **Add user** → **Create new user**
   - Email: `mstjames@zoho.com`
   - Password: pick a strong one
   - Tick **Auto Confirm User** (otherwise you'll be stuck waiting on a confirmation email)
   - Click **Create user**

2. **Authentication** → **Sign In / Providers** → **Email**
   - Turn **OFF** "Allow new users to sign up"
   - Save

Now yours is the only account that can ever exist.

---

## 4. Push it live

In your terminal, from the project folder:

```
git add .
git commit -m "Add admin backend with Supabase"
git push
```

Wait about a minute for Netlify to build, then go to:

**squishly.netlify.app/admin/login.html**

Sign in with the email and password from step 3.

---

## What you can do now

| Page | What it's for |
|---|---|
| **Dashboard** | Live product count, average margin, and anything needing attention |
| **Products** | Search, filter, edit. Profit and margin on every row |
| **Research** | Ideas you're weighing up. One click moves a winner into Drafts |
| **Settings** | Store details, and changing your password |

**Product statuses** — only **Active** appears on the shop:

- **Draft** — being worked on, invisible to customers
- **Active** — live on the shop
- **Hidden** — temporarily pulled, keeps all its data
- **Out of stock** — visible but flagged
- **Archived** — retired, kept for reference
- **Research** — an idea you're considering, never on the shop

---

## Important: the shop doesn't read the database yet

Right now the admin and the shop are two separate things:

- The **admin** reads and writes the Supabase database
- The **shop** still reads `products.js`

So editing a price in the admin **won't change the shop yet**. That's deliberate — it means
nothing customer-facing can break while we get the admin right.

Connecting them is the next step. Once that's done, an edit in the admin changes the live shop
within seconds.

---

## Is it safe that the key is in the code?

Yes. `admin/config.js` holds your project URL and a **publishable** key, both designed to be
public — they identify your project, they don't grant access to it.

What actually protects your data is the rules in `schema.sql`:

- Anonymous visitors **cannot read the products table at all** — not even product names
- The shop reads a separate cut-down view that deliberately leaves out your **supplier costs**,
  **supplier links**, and **private notes**
- Those rules are enforced by the database itself, so they hold even if someone bypasses the admin
  pages entirely

Verified before shipping: an anonymous request for `supplier_cost` is refused outright.

**The one thing to never commit** is the `service_role` (secret) key from your Supabase API
settings — that one bypasses every rule. It isn't in this project, and it shouldn't be.
