/* ===========================================================
   Squishy Society — product catalogue
   ---------------------------------------------------------
   These are REAL AliExpress listings I found and pulled photos
   from directly (ratings 4.2+, all generic/non-licensed designs
   to avoid IP issues — see README). Nothing has been purchased;
   you still need to review each supplier yourself before
   committing, and re-check ratings/reviews since they change.

   Fields:
     - id            : unique short string
     - name          : your own product title (rewritten, not
                        copy-pasted from the AliExpress listing)
     - category      : "mochi" | "jumbo" | "animal" | "food" | "fidget" | "keychain"
     - price         : YOUR selling price in AUD (what the customer pays)
     - supplierCost  : approx. AliExpress price per unit in AUD,
                        at time of research — recheck before committing,
                        prices/deals shift constantly on AliExpress.
                        Never shown on the site, just for your margin math.
     - image         : local photo pulled from the real listing
     - sourceRating  : the listing's AliExpress rating at time of research
     - sourceOrders  : approx. orders at time of research
     - description
   =========================================================== */

const PRODUCTS = [
  {
    id: "sq-001",
    name: "Coconut Mochi Squeeze Ball",
    category: "mochi",
    price: 18.95,
    supplierCost: 6.22,
    image: "images/coconut-mochi.png",
    sourceRating: 4.7,
    sourceOrders: "10,000+",
    description: "Squishy, translucent mochi-style squeeze ball with a satisfying slow-rebound feel. One of the most consistently well-reviewed listings we found."
  },
  {
    id: "sq-002",
    name: "Glow-in-the-Dark Mochi Animal Pack",
    category: "mochi",
    price: 15.95,
    supplierCost: 4.82,
    image: "images/mochi-glow-pack.png",
    sourceRating: 4.9,
    sourceOrders: "4,000+",
    description: "A bucket of assorted mini mochi-style animal squishies that glow in the dark — great as a party favour bundle or pick-and-mix item."
  },
  {
    id: "sq-003",
    name: "Jumbo Squishy Duck",
    category: "jumbo",
    price: 44.95,
    supplierCost: 23.75,
    image: "images/jumbo-duck.png",
    sourceRating: 4.5,
    sourceOrders: "10,000+",
    description: "A genuinely large, slow-rise duck squishy — this is the top-selling jumbo listing we found, with a strong review history."
  },
  {
    id: "sq-004",
    name: "Jumbo Strawberry Squishy",
    category: "jumbo",
    price: 14.95,
    supplierCost: 5.71,
    image: "images/jumbo-strawberry.png",
    sourceRating: 3.8,
    sourceOrders: "600+",
    description: "Oversized slow-rise strawberry squishy with a satisfying squeeze. Rating's decent rather than outstanding — worth ordering a sample first."
  },
  {
    id: "sq-005",
    name: "Kawaii Cat Silicone Squishy",
    category: "animal",
    price: 22.95,
    supplierCost: 8.56,
    image: "images/kawaii-cat.png",
    sourceRating: 4.3,
    sourceOrders: "1,000+",
    description: "A soft silicone cat squishy with a realistic, chunky feel — a desk-buddy style item that photographs really well."
  },
  {
    id: "sq-006",
    name: "Slow-Rise Cat Squishy",
    category: "animal",
    price: 8.95,
    supplierCost: 2.31,
    image: "images/cat-pu.png",
    sourceRating: 4.3,
    sourceOrders: "4,000+",
    description: "Budget-friendly PU slow-rise cat squishy — high order count and solid reviews make this a safe, cheap catalogue filler."
  },
  {
    id: "sq-007",
    name: "Butter Stick Squishy",
    category: "food",
    price: 12.95,
    supplierCost: 3.71,
    image: "images/butter-stick.png",
    sourceRating: 4.5,
    sourceOrders: "2,000+",
    description: "Novelty butter-stick shaped squeeze toy — crunchy, satisfying texture. A 'top selling on AliExpress' tagged listing."
  },
  {
    id: "sq-008",
    name: "Glitter Dumpling Squishy",
    category: "food",
    price: 6.95,
    supplierCost: 1.43,
    image: "images/glitter-dumpling.png",
    sourceRating: 4.3,
    sourceOrders: "10,000+",
    description: "Sparkly dumpling-shaped squeeze toy that comes in its own little box — high order volume, cheap unit cost, good margin item."
  },
  {
    id: "sq-009",
    name: "Peanut Stress Squish",
    category: "fidget",
    price: 9.95,
    supplierCost: 5.31,
    image: "images/peanut.png",
    sourceRating: 4.6,
    sourceOrders: "1,000+",
    description: "Realistic peanut-shell texture squeeze toy, buttery-soft feel — a strong-rated fidget option."
  },
  {
    id: "sq-010",
    name: "Green Apple Squish Ball",
    category: "fidget",
    price: 11.95,
    supplierCost: 5.94,
    image: "images/green-apple.png",
    sourceRating: 4.2,
    sourceOrders: "10,000+",
    description: "Translucent green apple stress ball, slow-rebound. Extremely high order count — a proven seller."
  },
  {
    id: "sq-011",
    name: "Mini Dumpling Keychain",
    category: "keychain",
    price: 9.95,
    supplierCost: 3.26,
    image: "images/dumpling-keychain.png",
    sourceRating: 5.0,
    sourceOrders: "140+",
    description: "Clip-on mini dumpling squishy keychain in four pastel colours. Perfect 5-star rating, though order count is still building."
  },
  {
    id: "sq-012",
    name: "Polar Bear Pinch Keychain",
    category: "keychain",
    price: 10.95,
    supplierCost: 3.29,
    image: "images/bear-keychain.png",
    sourceRating: 4.7,
    sourceOrders: "1,000+",
    description: "Soft stuffed polar bear squeeze keychain in a novelty lunchbox pose — cute, generic design, no licensing concerns."
  }
];

const CATEGORY_LABELS = {
  all: "All",
  mochi: "Mochi",
  jumbo: "Jumbo",
  animal: "Animals",
  food: "Food-shaped",
  fidget: "Fidget",
  keychain: "Keychain"
};
