/* ===========================================================
   Squishy Society — product catalogue (64 products)
   ---------------------------------------------------------
   sq-001 to sq-012 : original picks, photos stored locally in /images
   sq-013 to sq-062 : added later, photos hot-linked from AliExpress's CDN
   sq-063 onward    : also carry `sourceUrl` + `shippingCost` — see
                      product-tracker.xlsx for the master pricing sheet.

   All entries are REAL AliExpress listings. sq-001 to sq-062 were filtered
   to 500+ units sold and 4.0+ rating; the prism cubes (sq-063+) are a
   lower-volume niche so that bar was relaxed for them specifically.
   Licensed/branded character items are excluded throughout
   (no Pokemon, Sanrio, Disney, Ghibli, NeeDoh etc) to avoid IP risk.

   IMPORTANT NOTES
   - `supplierCost` is the AliExpress price in AUD at time of research.
     AliExpress pricing moves constantly — re-check before committing.
   - `shippingCost` (sq-063+) is what that listing charged at time of
     research, separate from supplierCost. Older entries don't have this
     field recorded — see product-tracker.xlsx.
   - `sourceUrl` (sq-063+) links to the exact AliExpress listing this was
     sourced from. Update this directly in product-tracker.xlsx if you
     switch suppliers — see that file's Instructions tab.
   - `sourceRating` / `sourceOrders` were accurate at time of research
     and are for YOUR reference only; they are shown on the product
     popup but you may want to remove that once you have your own reviews.
   - Products sq-013+ load their photos directly from AliExpress's servers.
     That works today but those links can break without warning. Before
     you launch properly, replace them with your own product photos and
     put them in /images like the first twelve.
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
    description: "A bucket of assorted mini mochi-style animal squishies that glow in the dark \u2014 great as a party favour bundle or pick-and-mix item."
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
    description: "A genuinely large, slow-rise duck squishy \u2014 this is the top-selling jumbo listing we found, with a strong review history."
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
    description: "Oversized slow-rise strawberry squishy with a satisfying squeeze. Rating's decent rather than outstanding \u2014 worth ordering a sample first."
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
    description: "A soft silicone cat squishy with a realistic, chunky feel \u2014 a desk-buddy style item that photographs really well."
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
    description: "Budget-friendly PU slow-rise cat squishy \u2014 high order count and solid reviews make this a safe, cheap catalogue filler."
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
    description: "Novelty butter-stick shaped squeeze toy \u2014 crunchy, satisfying texture. A 'top selling on AliExpress' tagged listing."
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
    description: "Sparkly dumpling-shaped squeeze toy that comes in its own little box \u2014 high order volume, cheap unit cost, good margin item."
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
    description: "Realistic peanut-shell texture squeeze toy, buttery-soft feel \u2014 a strong-rated fidget option."
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
    description: "Translucent green apple stress ball, slow-rebound. Extremely high order count \u2014 a proven seller."
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
    description: "Soft stuffed polar bear squeeze keychain in a novelty lunchbox pose \u2014 cute, generic design, no licensing concerns."
  },
  {
    id: "sq-013",
    name: "Clicker Button Fidget Keychain",
    category: "keychain",
    price: 8.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sfa7d655094a94f7297981ec2bab662aeq.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "4,000+",
    description: "Tiny clicky button keychain with a soft slow-rebound press. Quiet enough for a desk, satisfying enough to keep going."
  },
  {
    id: "sq-014",
    name: "Polar Bear Lunchbox Squish Keychain",
    category: "keychain",
    price: 11.95,
    supplierCost: 3.27,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S88c5c04fda174c46bc0fa94a2e92c501S.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "1,000+",
    description: "A little polar bear tucked into a bento box, on a clip. Squeeze the bear, it pops back slowly."
  },
  {
    id: "sq-015",
    name: "Cartoon Bear Squeak Keychain",
    category: "keychain",
    price: 8.95,
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
    price: 7.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sfc0f13ce3c7b41829d24738ff42e4d29x.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.8,
    sourceOrders: "500+",
    description: "Plush star charm with a gentle squeak — the cheapest way to add something soft to a backpack."
  },
  {
    id: "sq-017",
    name: "Bear Bento Squish Bag Charm",
    category: "keychain",
    price: 8.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S40acbab97e6943fbbfbf14d65dfc534fH.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.8,
    sourceOrders: "500+",
    description: "Bear-in-a-lunchbox bag charm with a squishy slow-rise body. Same idea as the keychain, sized for a bag."
  },
  {
    id: "sq-018",
    name: "Keyboard Clicker Fidget Keychain",
    category: "keychain",
    price: 8.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sa85a5ce826ca49a2b109c61aa8b614edt.png",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Four or nine mechanical-style keys on a keyring, purely for clicking. One of the highest-volume fidget listings we found."
  },
  {
    id: "sq-019",
    name: "Clear Mochi Squeeze Blob",
    category: "mochi",
    price: 18.95,
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
    price: 14.95,
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
    price: 15.95,
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
    price: 17.95,
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
    id: "sq-024",
    name: "Ocean Sensory Stress Ball",
    category: "fidget",
    price: 16.95,
    supplierCost: 5.55,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sf82332c320974ce1b9f94ecad94bd12cG.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Ocean-themed squish ball marketed for sensory and anxiety relief. Very high order volume with strong ratings."
  },
  {
    id: "sq-025",
    name: "Slow-Rise Sensory Cube",
    category: "fidget",
    price: 14.95,
    supplierCost: 4.84,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sd6b66416c6774a65b46b11a7f7090037I.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Cube-shaped slow-rising squish — squash it into any shape and watch it climb back."
  },
  {
    id: "sq-026",
    name: "Mystery Squishy Blind Box",
    category: "fidget",
    price: 10.95,
    supplierCost: 3.22,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S977d91c9253240dd81838fb05546feb3J.png_480x480.png_.avif",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Random slow-rise squishy in a sealed box. Blind boxes do well as impulse add-ons at checkout."
  },
  {
    id: "sq-027",
    name: "Crunchy Soap Bar Squish Ball",
    category: "fidget",
    price: 49.95,
    supplierCost: 22.39,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S7ba36c5ac7294ad593df6a2f65be6f10P.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.6,
    sourceOrders: "10,000+",
    description: "Soap-bar squish with the crunchy ASMR filling. Our priciest fidget, and the volume suggests people pay it."
  },
  {
    id: "sq-028",
    name: "Anti-Anxiety Squish Ball",
    category: "fidget",
    price: 23.95,
    supplierCost: 9.10,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S3acbca73450944b58dd1f86607aa11f9J.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Dense squeeze ball aimed at ADHD and anxiety fidgeting. Holds up to repeated hard squeezing."
  },
  {
    id: "sq-029",
    name: "Ocean Squish Cube",
    category: "fidget",
    price: 14.95,
    supplierCost: 4.86,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S347c1e2e88b64e0ebfc1d9a9aa4a9707R.jpg",
    sourceRating: 4.6,
    sourceOrders: "10,000+",
    description: "Gel-filled cube with a drifting ocean look inside. Slow rebound, good desk piece."
  },
  {
    id: "sq-030",
    name: "Gel-Filled Squish Cube",
    category: "fidget",
    price: 8.95,
    supplierCost: 2.16,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sb1a2be537111402dbf5875b084dbd5c1T.jpeg_480x480q75.jpeg_.avif",
    sourceRating: 4.0,
    sourceOrders: "10,000+",
    description: "Stretchy gel cube at the cheapest end of the range. Rating is only 4.0 — worth sampling before you commit."
  },
  {
    id: "sq-031",
    name: "Rainbow 3D Sensory Ball",
    category: "fidget",
    price: 12.95,
    supplierCost: 4.32,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S66010cec364349128a65351cb582f78dI.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.3,
    sourceOrders: "2,000+",
    description: "Rainbow-layered squish ball with a textured 3D surface for extra tactile feedback."
  },
  {
    id: "sq-032",
    name: "Giant Strawberry Squishy",
    category: "jumbo",
    price: 46.95,
    supplierCost: 20.83,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S591c4342cdbf4fe3add32dae644335b0C.jpg",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Oversized strawberry squish, two-handed size. Statement piece and a strong photo/video product."
  },
  {
    id: "sq-033",
    name: "Giant Cheese Cube Squish",
    category: "jumbo",
    price: 39.95,
    supplierCost: 16.61,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S9a73196b491e42abac1a33f0a36d22dfZ.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Extra-large mouldable cheese cube. Squash it into a shape and it holds, then slowly relaxes."
  },
  {
    id: "sq-034",
    name: "Popcorn Bucket Squishy",
    category: "jumbo",
    price: 10.95,
    supplierCost: 2.98,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S74248d4b250444b9849ae221a6228e7fd.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "4,000+",
    description: "Slow-rising popcorn bucket in soft PU. Cheap unit cost and a 4.9 rating — strong margin item."
  },
  {
    id: "sq-035",
    name: "Jumbo Cheese Squish Block",
    category: "jumbo",
    price: 23.95,
    supplierCost: 9.37,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S990f9bfa406a44fa8fa277b8f64a6aa8F.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "10,000+",
    description: "Mid-size shapeable cheese block. The volume seller of the cheese range."
  },
  {
    id: "sq-036",
    name: "Salamander Malt Squish",
    category: "animal",
    price: 15.95,
    supplierCost: 5.26,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sc939c510bc9d42d8ac593b1b5fc38a0c7.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "5,000+",
    description: "Colourful salamander in stretchy malt-sugar material. Pulls and squishes without tearing."
  },
  {
    id: "sq-037",
    name: "Aurora Glitter Duck Squish",
    category: "animal",
    price: 12.95,
    supplierCost: 4.11,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S7a8b8874a805412dae82a68beaa5630f8.png_480x480.png_.avif",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Transparent duck with aurora glitter suspended inside. Stretches as well as it squishes."
  },
  {
    id: "sq-038",
    name: "Axolotl Squeeze Ball",
    category: "animal",
    price: 9.95,
    supplierCost: 2.76,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sfc0d3c4eea04453ebfc1a0243245569cY.jpg",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Axolotls are having a moment and this one is cheap, well-rated, and slow-rising."
  },
  {
    id: "sq-039",
    name: "Unicorn Slow-Rise Squishy",
    category: "animal",
    price: 10.95,
    supplierCost: 3.27,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/H1e0cdcf8c87a44b7bb12c9c95ede588dx.jpg",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Soft PU unicorn with a slow rise. Generic design, no licensing attached."
  },
  {
    id: "sq-040",
    name: "Big Chicken Slow-Rise Squishy",
    category: "animal",
    price: 10.95,
    supplierCost: 2.98,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S004bcc4f873348d98c6ffadc7145692do.jpeg",
    sourceRating: 4.9,
    sourceOrders: "4,000+",
    description: "Oversized novelty chicken with a scented, slow-rebound body. Sells on sheer absurdity."
  },
  {
    id: "sq-041",
    name: "Cat Paw Squish Toy",
    category: "animal",
    price: 11.95,
    supplierCost: 3.56,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S167758f8d3c149ae93105144b3197e36C.jpg",
    sourceRating: 4.5,
    sourceOrders: "3,000+",
    description: "Soft cat paw with a slightly sticky, decompressing surface. Small enough for a pocket."
  },
  {
    id: "sq-042",
    name: "Octopus Squish Toy",
    category: "animal",
    price: 13.95,
    supplierCost: 4.47,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S8b11302bebc8450588ede5a6bdb4b8b2K.jpg",
    sourceRating: 4.6,
    sourceOrders: "2,000+",
    description: "Simulated octopus with squishy legs — more texture variety than a plain ball."
  },
  {
    id: "sq-043",
    name: "Glitter Gummy Capybara",
    category: "animal",
    price: 16.95,
    supplierCost: 5.47,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S526c613a536e4ae4aa397037a5570d6et.jpg",
    sourceRating: 4.9,
    sourceOrders: "800+",
    description: "Capybara in translucent glitter gummy material. Rides the capybara trend with a 4.9 rating."
  },
  {
    id: "sq-044",
    name: "Glitter Turtle Squish",
    category: "animal",
    price: 11.95,
    supplierCost: 3.58,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sba73380d2c1a48e5856571243287910fA.jpeg",
    sourceRating: 4.9,
    sourceOrders: "800+",
    description: "Small glitter-filled turtle. Newer listing, but the rating is excellent so far."
  },
  {
    id: "sq-045",
    name: "Capybara Bakery Squishy",
    category: "animal",
    price: 26.95,
    supplierCost: 10.74,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S5ce217887fbb4da38c0c9982c34bab81i.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "1,000+",
    description: "Capybara shaped like a bakery pastry — the two biggest squishy trends in one item. Premium price point."
  },
  {
    id: "sq-046",
    name: "Glitter Bear Slow-Rise Squishy",
    category: "animal",
    price: 10.95,
    supplierCost: 3.37,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S5544a197dc7f473e863cf91128610b98n.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "4,000+",
    description: "Colourful glitter bear with a slow rebound. Cheap, cheerful, and rated 4.9."
  },
  {
    id: "sq-047",
    name: "Colour-Changing Mango Squish",
    category: "food",
    price: 16.95,
    supplierCost: 5.67,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S9784ecf2102d4017908c7b70deb556b0N.png_480x480.png_.avif",
    sourceRating: 4.4,
    sourceOrders: "5,000+",
    description: "Mango squish that shifts colour as you squeeze it, with a crunchy ASMR filling."
  },
  {
    id: "sq-048",
    name: "Rainbow Dumpling Basket Squishy",
    category: "food",
    price: 18.95,
    supplierCost: 6.36,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S6e64b560d7f4410e95c7f1b9e5e83c86O.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "10,000+",
    description: "Rainbow dumplings in a little bamboo steamer basket. Presentation makes this an easy gift item."
  },
  {
    id: "sq-049",
    name: "Mini Toast Slice Squishy",
    category: "food",
    price: 9.95,
    supplierCost: 2.30,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Se134418ab46242be88549e2bfd4758e4S.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "5,000+",
    description: "Small slow-rising toast slice. Very low unit cost with a 4.9 rating — good entry-price product."
  },
  {
    id: "sq-050",
    name: "Gold Glitter Dumpling Squishy",
    category: "food",
    price: 54.95,
    supplierCost: 24.91,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sf0792c013b49427f88ea2200fdf7055aK.jpg",
    sourceRating: 4.1,
    sourceOrders: "5,000+",
    description: "The premium gold-glitter version of the dumpling squish. Priciest item in the range; rating is 4.1, so sample it first."
  },
  {
    id: "sq-051",
    name: "Snack Trio Squish Set",
    category: "food",
    price: 13.95,
    supplierCost: 4.58,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sc8c886a655f4423a90d2cab0e383e088B.png_480x480.png_.avif",
    sourceRating: 4.9,
    sourceOrders: "2,000+",
    description: "Peanut, corn and burger squishies sold as a set. Bundles like this lift average order value."
  },
  {
    id: "sq-052",
    name: "Double-Sided Rice Cake Squishy",
    category: "food",
    price: 18.95,
    supplierCost: 6.25,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sbeeab91acd4146229cab84d7ea93fe9cH.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "3,000+",
    description: "Pink rice cake with a different texture on each side and a slow rise."
  },
  {
    id: "sq-053",
    name: "Crispy Mango Stress Ball",
    category: "food",
    price: 16.95,
    supplierCost: 5.65,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sd5c5d4705c564ec48ec25a66aaa65f34e.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "3,000+",
    description: "Handmade-style mango squish with a crunchy interior that changes colour under pressure."
  },
  {
    id: "sq-054",
    name: "LED Glow Bun Squishy",
    category: "food",
    price: 12.95,
    supplierCost: 3.57,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S9ba0951a6d8d4f1caa20c859ec24c0fay.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.0,
    sourceOrders: "2,000+",
    description: "Silicone bun that lights up from inside — doubles as a soft night light. Rating is 4.0, so check reviews."
  },
  {
    id: "sq-055",
    name: "Dragon Fruit Squish Ball",
    category: "food",
    price: 12.95,
    supplierCost: 4.06,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S130f7d3cdb704ae7b895f5c4151e6f539.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.6,
    sourceOrders: "1,000+",
    description: "Dragon fruit squish with speckled interior detail. Distinctive enough to stand out in a grid."
  },
  {
    id: "sq-056",
    name: "Butter Toast Squishy",
    category: "food",
    price: 15.95,
    supplierCost: 5.28,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sdb4bf9ad8ae04420ad9fb88f7099a000Z.jpg",
    sourceRating: 4.9,
    sourceOrders: "1,000+",
    description: "Buttered toast slice with a realistic slow rise. One of the better-finished food squishies we saw."
  },
  {
    id: "sq-057",
    name: "Durian & Dragon Fruit Crunch Set",
    category: "food",
    price: 21.95,
    supplierCost: 7.82,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sb4d7919b81b94287a165967b5d3193dab.jpg",
    sourceRating: 4.9,
    sourceOrders: "1,000+",
    description: "Two crunchy-filled fruit squishies sold together. Unusual shapes, strong ASMR appeal."
  },
  {
    id: "sq-058",
    name: "Mini Food Squishy Variety Pack",
    category: "food",
    price: 11.95,
    supplierCost: 3.18,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S02e32d6c0910435e8a92af3b7101e2cdj.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.5,
    sourceOrders: "3,000+",
    description: "Fourteen mini food squishies — bread, butter, cheese and fruit shapes — in one pack."
  },
  {
    id: "sq-059",
    name: "Pink Steamed Bun Squishy",
    category: "food",
    price: 7.95,
    supplierCost: 1.42,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sb7e0880bbbfe4bdf884605d8b65571bc3.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.6,
    sourceOrders: "2,000+",
    description: "Simple pink steamed bun with a soft slow rebound. Lowest unit cost in the catalogue."
  },
  {
    id: "sq-060",
    name: "Big Cookie Squishy",
    category: "food",
    price: 15.95,
    supplierCost: 5.25,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S4570ae5a9b6d4e4e9169401ab32409b0B.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.6,
    sourceOrders: "2,000+",
    description: "Oversized cookie squish with baked-in surface detail."
  },
  {
    id: "sq-061",
    name: "Grape Bunch Squish Toy",
    category: "food",
    price: 16.95,
    supplierCost: 5.53,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/S246d2b5e718b4f2e8b46e24f71e4b812r.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.9,
    sourceOrders: "2,000+",
    description: "Bunch of grapes where each grape squishes individually — unusually good tactile variety."
  },
  {
    id: "sq-062",
    name: "Grilled Rice Cake Squishy",
    category: "food",
    price: 15.95,
    supplierCost: 5.44,
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Se646a6e5f78f412296ff962a0ae7c172Y.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.7,
    sourceOrders: "2,000+",
    description: "Grilled rice cake with a browned, textured surface and a slow rise."
  },

  {
    id: "sq-063",
    name: "Rainbow Prism Cube",
    category: "prism",
    price: 21.95,
    supplierCost: 7.40,
    shippingCost: 3.12,
    sourceUrl: "https://www.aliexpress.com/item/1005005399618112.html",
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Sc8944e13c9ee46b18de226cad1983ac5H.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "600+",
    description: "A solid crystal cube that splits light into shifting rainbow colour as you turn it in your hand — more hypnotic than squishy, for anyone who likes a visual fidget as much as a tactile one. Comes in four sizes."
  },

  {
    id: "sq-064",
    name: "Studio Light Prism Cube",
    category: "prism",
    price: 27.95,
    supplierCost: 11.86,
    shippingCost: 0,
    sourceUrl: "https://www.aliexpress.com/item/1005009157109845.html",
    image: "https://ae-pic-a1.aliexpress-media.com/kf/Se72f4cb26aeb41a7bf95d4171701f91fE.jpg_480x480q75.jpg_.avif",
    sourceRating: 4.4,
    sourceOrders: "700+",
    description: "A hexahedral CMY crystal cube built for photographers chasing prism-flare shots, but just as fun to fidget with on a desk. Free shipping on this listing. Comes in two sizes."
  }
];

const CATEGORY_LABELS = {
  all: "All",
  mochi: "Mochi",
  jumbo: "Jumbo",
  animal: "Animals",
  food: "Food-shaped",
  fidget: "Fidget",
  keychain: "Keychain",
  prism: "Prism Cubes"
};
