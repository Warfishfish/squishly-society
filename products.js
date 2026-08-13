/* ===========================================================
   Squishy Society — product catalogue (13 products)
   sq-064 (Studio Light Prism Cube) was removed on request.
   Prism is now a single-product category — worth adding a second
   prism item before that category reads as thin to a customer.
   sq-012, sq-014, sq-017 were removed: the only real AliExpress listings
   for that "bear in a lunchbox with chopsticks" style are branded
   "Chiikawa" (a licensed character) in their own specifications — an IP
   risk this catalogue otherwise screens out. sq-013 was renamed from
   "Clicker Button Fidget Keychain" to "Mini Food Charm Keychain Set" —
   its actual photo/data was a food-charm set, not a clicker (that's
   sq-018, a different real product).
   ---------------------------------------------------------
   Niche committed: Mochi, Prism Cubes, Keychain. The other four
   categories (Jumbo, Animals, Food-shaped, Fidget — 47 products) were
   removed from the catalogue on this date. If you want to bring any
   back later, they are recoverable from an earlier commit in git
   history (git log to find one before this cleanup, then
   git show <commit>:products.js).

   sq-001, sq-002, sq-011, sq-012 : original picks, photos stored locally in /images
   sq-013 to sq-023               : hot-linked from AliExpress's CDN
   sq-063 onward                  : carry sourceUrl + shippingCost —
                                     see product-tracker.xlsx for the master pricing sheet.

   All entries are REAL AliExpress listings. Licensed/branded character
   items are excluded (no Pokemon, Sanrio, Disney, Ghibli, NeeDoh etc)
   to avoid IP risk.

   IMPORTANT NOTES
   - supplierCost is the AliExpress price in AUD at time of research.
     AliExpress pricing moves constantly — re-check before committing.
   - shippingCost (sq-063+) is what that listing charged at time of
     research, separate from supplierCost. Older entries do not have
     this field recorded yet — see product-tracker.xlsx.
   - sourceUrl (sq-063+) links to the exact AliExpress listing this was
     sourced from. Update this directly in product-tracker.xlsx if you
     switch suppliers.
   - sourceRating / sourceOrders were accurate at time of research and
     are for YOUR reference only.
   - Products sq-013+ load their photos directly from AliExpress's
     servers. That works today but those links can break without warning.
   =========================================================== */

var PRODUCTS = [
  {
    id: "sq-001",
    name: "Coconut Mochi Squeeze Ball",
    category: "mochi",
    price: 18.95,
    supplierCost: 7.16,
    shippingCost: 3.09,
    sourceUrl: "https://www.aliexpress.com/item/1005012612601681.html",
    image: "images/coconut-mochi.png",
    sourceRating: 4.5,
    sourceOrders: "286+",
    description: "Squishy, translucent mochi-style squeeze ball with a satisfying slow-rebound feel. Comes in six colours, 6cm each."
  },

  {
    id: "sq-002",
    name: "Glow-in-the-Dark Mochi Animal Pack",
    category: "mochi",
    price: 16.95,
    supplierCost: 7.61,
    shippingCost: 0,
    sourceUrl: "https://www.aliexpress.com/item/1005006252139979.html",
    image: "images/mochi-glow-pack.png",
    sourceRating: 4.6,
    sourceOrders: "3,000+",
    description: "A bucket of assorted mini mochi-style animal squishies that glow in the dark — great as a party favour bundle or pick-and-mix item. Free shipping on this listing. Comes in four pack sizes, priced differently."
  },

  {
    id: "sq-011",
    name: "Mini Dumpling Keychain",
    category: "keychain",
    price: 4.95,
    supplierCost: 2.12,
    shippingCost: 0,
    sourceUrl: "https://www.aliexpress.com/item/1005009663405697.html",
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sa976459fb7724bf1bca6e153a425a8ebg.png",
    sourceRating: 4.9,
    sourceOrders: "700+",
    description: "A soft plush dumpling-shaped keychain with a stitched-on smiley face — cute, pillowy, and instantly recognisable. Free shipping on this listing. Sold in packs of 1 to 5, priced per pack."
  },

  {
    id: "sq-013",
    name: "Mini Food Charm Keychain Set",
    category: "keychain",
    price: 6.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sfa7d655094a94f7297981ec2bab662aeq.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "4,000+",
    description: "A set of tiny food-shaped squish charms — pancake stack, soft-boiled eggs, a mini cake, a dumpling — on ball-chain keyring clips. Sold in sets of 5 or 20."
  },

  {
    id: "sq-015",
    name: "Cartoon Bear Squeak Keychain",
    category: "keychain",
    price: 6.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Seabcbe1ddb33471abf6993096cf1e09c9.jpg",
    sourceRating: 4.8,
    sourceOrders: "600+",
    description: "Soft bear pendant with a built-in squeak. Clips onto a bag strap or keyring."
  },

  {
    id: "sq-016",
    name: "Star Plush Squeak Keychain",
    category: "keychain",
    price: 5.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sfc0f13ce3c7b41829d24738ff42e4d29x.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.8,
    sourceOrders: "500+",
    description: "Plush star charm with a gentle squeak — the cheapest way to add something soft to a backpack."
  },

  {
    id: "sq-018",
    name: "Keyboard Clicker Fidget Keychain",
    category: "keychain",
    price: 5.95,
    supplierCost: 2.01,
    shippingCost: 0,
    sourceUrl: "https://www.aliexpress.com/item/1005010788802674.html",
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sa85a5ce826ca49a2b109c61aa8b614edt.png",
    sourceRating: 4.8,
    sourceOrders: "2,000+",
    description: "Pastel mechanical-style keycaps on a keyring, purely for clicking. Comes as a single cube, a row of four, a cross of five, or a full 3x3 grid of nine. Free shipping on this listing."
  },

  {
    id: "sq-019",
    name: "Clear Mochi Squeeze Blob",
    category: "mochi",
    price: 13.95,
    supplierCost: 6.63,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sb90d248920754776bb465dfaaaa86a13n.png_480x480.png_.avif",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Translucent mochi blob that squashes flat and slowly reforms. The see-through version of the classic mochi squish."
  },

  {
    id: "sq-020",
    name: "Pink Ice Ball Mochi Squish",
    category: "mochi",
    price: 11.95,
    supplierCost: 5.06,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Scbd5587abf1d47d4922220046474e2954.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Soft pink maltose-style ball with a slow rebound and a slightly tacky, ice-like surface."
  },

  {
    id: "sq-021",
    name: "Strawberry Mochi Squeeze Toy",
    category: "mochi",
    price: 12.95,
    supplierCost: 5.28,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S0bdc6f4eb19445f38eed9512c2386ab6i.png_480x480.png_.avif",
    sourceRating: 4.4,
    sourceOrders: "5,000+",
    description: "Strawberry-shaped mochi squish built for hard squeezing — marketed squarely at stress relief."
  },

  {
    id: "sq-022",
    name: "Blue Maltose Mochi Ball",
    category: "mochi",
    price: 13.95,
    supplierCost: 5.96,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S2e9a08405d994142813ae55d1e3a851f3.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "5,000+",
    description: "Transparent blue maltose ball with a quick rebound. Heavier in the hand than it looks."
  },

  {
    id: "sq-023",
    name: "Mochi Animal Mega Pack (50pc)",
    category: "mochi",
    price: 44.95,
    supplierCost: 19.53,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sd136312a9b8b47ac8b7f63028b5a3cf5I.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "3,000+",
    description: "Fifty assorted mini mochi animals in one bag. Built for party favours, classroom prizes, or a pick-and-mix display."
  },

  {
    id: "sq-063",
    name: "Rainbow Prism Cube",
    category: "prism",
    price: 21.95,
    supplierCost: 7.4,
    shippingCost: 3.12,
    sourceUrl: "https://www.aliexpress.com/item/1005005399618112.html",
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sc8944e13c9ee46b18de226cad1983ac5H.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "600+",
    description: "A solid crystal cube that splits light into shifting rainbow colour as you turn it in your hand — more hypnotic than squishy, for anyone who likes a visual fidget as much as a tactile one. Comes in four sizes."
  }
];

var CATEGORY_LABELS = {
  all: "All",
  mochi: "Mochi",
  food: "Food Squish",
  giant: "Giants",
  dumpling: "Dumplings",
  animal: "Animals",
  mystery: "Mystery Boxes",
  keychain: "Keychain",
  prism: "Prism Cubes"
};
