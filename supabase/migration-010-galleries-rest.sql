-- ===========================================================
-- Migration 010 — galleries for the rest of the catalogue
-- ===========================================================
-- Paste the CONTENTS of this file into Supabase → SQL Editor → Run.
--
-- Every image below was loaded and looked at before being written in.
-- That check is not a formality. Across this batch it caught a
-- photograph of a woman, a piece of anime fan art, a blue gel cube and
-- a strawberry sitting in a butter product's gallery, and a listing
-- that had quietly swapped to selling a different product entirely.
-- All were dropped rather than shipped.
--
-- Safe to re-run.
-- ===========================================================

begin;

-- -----------------------------------------------------------
-- sq-065 · Giant Dumpling Squishy                   9 photos
-- -----------------------------------------------------------
-- The full colour range in their steamers, plus a sized shot.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc078691382a74118a094474a2939521e3.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S29271ddcb4d7426b942d82b49331d087E.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd715695f33f247298af81331d7c6a873o.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb10317fc673e40288c6bc5a6cad34be8U.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sfb5d60c12b1744b2bfaaba533c653d4aj.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S547f773d59a847cea2e1aa7caa4e6774c.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sca9ccc41d0df47cea6713c811ab4227ca.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sfdb08a4666494bc9bb8498b99d7d2f23M.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sae422aa3e4724fa08fc13bbe59bf9ad8d.jpg'
] where sku = 'sq-065';


-- -----------------------------------------------------------
-- sq-067 · Capybara Bakery Squishy      9 photos + MAIN PHOTO
-- -----------------------------------------------------------
-- This is the listing that blocked the browser tool four times in an
-- earlier session and was left with no photo at all. It opened cleanly
-- this time, so it finally has a main image as well as a gallery.
update products set
  image = 'https://ae-pic-a1.aliexpress-media.com/kf/S33be64d554f9467c8127a5b36f544b71i.jpg',
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S33be64d554f9467c8127a5b36f544b71i.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sa2ea5f06cd2e4d76b68beb2c9f410fa68.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Scb37b62d05bd419a84c34fff18cd0074U.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S7686de93886b4dcfb1e0cd5b04dc04fdN.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sd92052c840dd4c3a8eed6e1826b56692V.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S5ce217887fbb4da38c0c9982c34bab81i.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S481bda051387423692ef131bdca170cak.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S48c3122d1c1a4352b71ed00bda58b3a36.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S4adc4d57862f4770ae4c27fd8b1fd093H.jpg'
  ]
where sku = 'sq-067';


-- -----------------------------------------------------------
-- sq-068 · Butter & Food Mystery Box                6 photos
-- -----------------------------------------------------------
-- ⚠️ Three images were dropped from this listing's own gallery: a blue
-- gel cube, a red strawberry, and — genuinely — a holiday snapshot of
-- a woman in sunglasses. That last one is a customer review photo that
-- had leaked into the gallery feed. Another reason this product is
-- still Research rather than Draft.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S3feb01c06f014fd79d105cad5078a13eY.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb3d3388e37a142dfa10500927be0e2f5d.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1fab07c6533d442d98cde2436c4ed2c8F.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S0619778d95eb4f8582bf09a64d2a7d4dO.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S6da1379891424672b7ccbc95ae94bd0av.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9698e4a5e20a47a6a44fb49fa1ca1845u.jpg'
] where sku = 'sq-068';


-- -----------------------------------------------------------
-- sq-070 · Giant Light Prism                        7 photos
-- -----------------------------------------------------------
-- Includes the rainbow-across-the-hand shot and the gift box, which
-- together do the work of justifying a $39.95 price.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa4b65f9dac104214816cafead5c80b6cw.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sf8689aba97764e61818dc14680c299baj.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S721863baa0a34d1fb49deffd305bd045s.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Se4753915ba1d4a25bb5f33b82d41dd90g.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc1328652a91d44f5be953af6103bb6cah.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa608094bb76449e6b751049ceb0f18d30.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sfbbf1038d35649d382098e2d48aa38dcx.jpg'
] where sku = 'sq-070';


-- -----------------------------------------------------------
-- sq-071 · 24-Day Squishy Advent Calendar           9 photos
-- -----------------------------------------------------------
-- Also replaces the main photo. It was previously the seller's
-- "WHY YOU'LL LOVE IT?" marketing infographic, flagged at the time as
-- the weakest image in the catalogue. The first gallery shot is a
-- plain product photo and belongs there instead.
update products set
  image = 'https://ae-pic-a1.aliexpress-media.com/kf/S10936f3808d2468a9ffb8e179dd089ff5.png',
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S10936f3808d2468a9ffb8e179dd089ff5.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/S7950c0647bd548a88ae72031409a580eb.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sb512ba4bb75c450fa1ad6cfadee89fb80.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sd4a133314b2049c0b1257daaf8107fa7f.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sf0ab7562205d48f496ac0e7754a507253.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sb3a98dc0ab72421db5bdbeca0f5265ea0.png',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sbfc4ed116fea4b52b6dc5fc9a416f3e8j.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sa882fdb5980e4b209cdc72af7cf48383l.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sd0e70c67ae0d4a25bfacb4b83e0c3a47F.png'
  ]
where sku = 'sq-071';


-- -----------------------------------------------------------
-- sq-072 · Mystery Dumpling Advent Calendar         9 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S21fe4e0f49974f8eaf287ddc486d8ca2I.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa83124aac9384f2d99341aaab3505c22J.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S82f78f8a8add47df9d24c1cf799003bbi.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Scd0cbc4539ed4d899e7349343304a47fN.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc3ac8ef97e9a4f30a2b75f9cd88d5263i.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd4845f188ca741038c5803ad3391a9f9i.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S764c83a2b66e445aabefc22837c7c5ffU.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9025ca3d3b944aa38214ca1593e1e2bfD.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sacaaf28e1b2c41cdb03b12c71a7b88fc6.jpg'
] where sku = 'sq-072';


-- -----------------------------------------------------------
-- sq-074 · Ocean Gel Cube                           7 photos
-- -----------------------------------------------------------
-- An eighth image was a piece of anime fan art with no connection to
-- the product. Dropped.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S7ef1f7c52f0a426c97120c3055308419g.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S5296ac9581e54830aed0ed98f9f76276J.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S13ce382d4c774ce69ccfd2d09a66a267H.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S5bfad815ae77435da951355668306ce12.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sf420608580c049639a1686426494504eb.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc106679062cf4ea591bf8eac0f7c0892v.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc30e330cae3b4aeea363780c564dcbf0c.jpg'
] where sku = 'sq-074';


-- -----------------------------------------------------------
-- sq-075 · Green Apple Squeeze Ball                 6 photos
-- -----------------------------------------------------------
-- Shows both the green and the blue colourway, which the listing
-- sells as variants of the same product.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S9de20148527449488dd6f167a9c167057.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S77ef99e5fb364de19489594504445338F.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S2b6f3f7bcdbb4532bd557272a30371af2.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S0636d40fc09e49aabc78ca2d44a9bde7s.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sbe0cd29471684765ade49b92d172d0150.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sac03d1a22fe04ad4bc9a0271e9238f32t.jpg'
] where sku = 'sq-075';


-- ===========================================================
-- sq-073 · Watermelon Slow-Rise Squishy — STOP AND READ
-- ===========================================================
-- The supplier listing for this product is no longer selling a
-- watermelon. Opening the same URL today returns:
--
--   "Soft Butter Stick Squishy Toy" — AU$8.05 regular, not AU$5.17
--
-- This is what an AliExpress "aggregate" listing can do: the URL
-- stays the same while the product behind it rotates. It also
-- explains something odd noticed when this product was first
-- sourced — its reviews were all describing a butter squishy.
--
-- So sq-073 currently points at a product that costs 56% more than
-- the price it was costed at, and is not the item its name, photo
-- and description promise. Selling it as-is would be misdescribing
-- goods, quite apart from the margin.
--
-- It is moved to Research below so it cannot go live by accident.
-- Nothing is deleted and no other field is touched, so this is
-- entirely reversible.
--
-- YOUR OPTIONS
--   a) Find a different watermelon supplier and repoint sq-073.
--   b) Rewrite it as the butter stick — but sq-089 Giant Butter
--      Stick already covers that, so it would duplicate.
--   c) Archive it.
--
-- Worth doing periodically for the whole catalogue: aggregate
-- listings drift, and this is the second one in this project to
-- change under us.
-- ===========================================================
update products
   set status = 'research',
       research_status = 'rejected',
       notes = notes || ' — 13 Aug 2026: SUPPLIER LISTING CHANGED PRODUCT. The URL now sells a "Soft Butter Stick Squishy Toy" at $8.05 regular, not a watermelon at $5.17. Moved to Research so it cannot go live misdescribed. Needs a new supplier, a rewrite, or archiving.'
 where sku = 'sq-073';


-- -----------------------------------------------------------
-- sq-077 · Rainbow Dumpling in a Steamer            4 photos
-- -----------------------------------------------------------
-- Four of this listing's eight images were marketing panels with
-- stock models and feature text. Only the plain shots kept.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S6e64b560d7f4410e95c7f1b9e5e83c86O.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S83a264ae1f9140ac9803162c59587139n.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc30516e8089a452d9dbd8a299718c344k.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S7cb444f70f0142d5bc260ca46c7c0888y.jpg'
] where sku = 'sq-077';


-- -----------------------------------------------------------
-- sq-079 · Cheese Cake Squish                       6 photos
-- -----------------------------------------------------------
-- Three images were pages of small-print manufacturing disclaimers
-- rather than photos. Dropped. Also replaces the main image, which
-- was the one carrying Chinese text.
update products set
  image = 'https://ae-pic-a1.aliexpress-media.com/kf/S6671e20e61564c0f8c00f96fbf5454a3Y.jpg',
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/S6671e20e61564c0f8c00f96fbf5454a3Y.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Se21a171a7e864074bfd211bb2c65bd6dZ.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sd3f18f240b204c74a445e4b8dc7c4e3dU.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S1454e82e788b49d6bad4b67f8ed4b24du.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S6e7f5ecd238e4810a6ea4c2ebbaf645fy.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S4bca6edeaf63415faf5bf93ccf3e23dbW.jpg'
  ]
where sku = 'sq-079';


-- -----------------------------------------------------------
-- sq-080 · Giant Strawberry Squishy                 8 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S591c4342cdbf4fe3add32dae644335b0C.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S32f91196dd684b018eb33bb2a2f5c48cJ.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S329c69fbd1594dd5a42b5856a4d8f65fC.jpeg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Se5aede6d9acf413ab6ced009ba9481edQ.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1b87ef53e96b41a29afc9d7e0fd41c3f7.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sbcec1499918a428aa4feacac4514ad74p.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S370e537787da40159ec3559125641c740.jpeg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S06bbe6e366b34be0ae6fdc1a197e24f5o.jpeg'
] where sku = 'sq-080';


-- -----------------------------------------------------------
-- sq-081 · Dumpling Trio in Steamers                7 photos
-- -----------------------------------------------------------
-- One image was a collage built around a stock model's face. Dropped.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S1444eced2b56453c999d39f4c6f4d9132.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Se0a5abbc93f042318e119bb93046c39bF.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S690b7bcc42144ac9aaa4f4575ed8758ag.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4607a7a4f4f74c7da5eded013214bcf9Z.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S387fe7a6ddc64569ae0f34c1691e365es.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb4dc4b5dacbc467da7e05845193e30e7Z.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S8707daa6f95c44339a74efe60d2b49bcb.jpg'
] where sku = 'sq-081';


-- -----------------------------------------------------------
-- sq-082 · Toast Slice Squish     9 photos + MAIN PHOTO FIXED
-- -----------------------------------------------------------
-- This is the product that had no photo at all, because the page
-- previously served an image that plainly was not toast.
--
-- With the full gallery visible, the reason is clear: the product is
-- a square milk-bread CUBE, not a slice of toast — sold in pink,
-- green and cream. The listing calls it "Square Bread / Small Toast".
-- The photos are right; the name in your catalogue is the misleading
-- part. WORTH RENAMING to "Square Bread Squish" before publishing,
-- and adjusting the description, which currently promises a slice
-- that flattens "with the crust still square".
update products set
  image = 'https://ae-pic-a1.aliexpress-media.com/kf/Se134418ab46242be88549e2bfd4758e4S.jpg',
  gallery = array[
    'https://ae-pic-a1.aliexpress-media.com/kf/Se134418ab46242be88549e2bfd4758e4S.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S68eefc6f576940cc97f5bf9ecbbe5957c.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sbbb9859b31d14dcb8f25e192a619d435a.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/See0ba8e615484b59a9fffcc0bc7ddca33.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sad26fca06c80474b8019fc60846563adm.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S5968d978045d48c884fd625495097ebdQ.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/Sf2d6d3c2cf214d5697b55a03e7145688P.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S570e7a7904ec4e1f9901a2a4517e0d5az.jpg',
    'https://ae-pic-a1.aliexpress-media.com/kf/S9eebca76453041c6a085412f49ffd308q.jpg'
  ]
where sku = 'sq-082';


-- -----------------------------------------------------------
-- sq-084 · Aurora Glitter Duck                      7 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S7a8b8874a805412dae82a68beaa5630f8.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S90f6a1c68c184d1f91928b4c0485590af.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd2070ad52eba456280ee97537141fc1du.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S7828babd4b1f426bb6aa706aafed078bI.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S6230d9d093144547a7bfe3d218833c12g.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4538cecdfd7144f5bddc103b45399a34G.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb3e7df2ff8ac43bb87fb8fdb403052c4v.png'
] where sku = 'sq-084';


-- -----------------------------------------------------------
-- sq-085 · Bubble Burger Bear                       8 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc89a675627af49728e661d5a4e487804K.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb89a98423eef43bdbdaf03e055804845w.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Saeba8a6e77e84490a102c1af4148c72f3.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb625c8ee86f74bb48ab291c1fd2caf1aa.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S061c556ebde0462b85b7767dcccd88a2i.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9ae5d6468c524735918690c1508d24e2t.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S40ca2f08b6f943cea820f6e37cecbe89M.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa11710a5751d4866b0c8f1b3eee29731B.jpg'
] where sku = 'sq-085';


-- -----------------------------------------------------------
-- sq-086 · Squeaky Goose Squish                     8 photos
-- -----------------------------------------------------------
-- A ninth image was a glitter duck — which is sq-084's product, not
-- this one. Dropped.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S1047dcbce6e44028ad5e2435efa2e186T.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S39a767115dda43a8b4fa61b3a1f6d4f2S.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Saed6049ffe1046488b22c96208bdb02dJ.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Saefa9edffab746d5b7cc7999890d8922j.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1513e194ce0b47629a1c9bd2af73b103b.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa097e4d79472474a80fc5a399622aeb63.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc9a31a85af9a45b29332cd80100254792.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Se188b6add9154a9b8700a50438a320e0q.jpg'
] where sku = 'sq-086';


-- -----------------------------------------------------------
-- sq-087 · Croissant Squish                         8 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S34cdfa8bc99c4410b35d17016dce88a5E.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc90e0ca9805940ea85caba31dfdc74c8q.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd84faa16747049fa9053618686101bda4.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sfe83656cc15b4679a5e5e12697227968K.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc1b75d033be946c6bd7b8cbdd91d3e9cA.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S62309dcd124f4c08bd79d52550293fbaA.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1e89b12363fc4f3eac4835dce4cafe19t.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4445ec71c2ab4a2385075c610deeba2fY.jpg'
] where sku = 'sq-087';


-- -----------------------------------------------------------
-- sq-088 · Giant Chick Squishy                      5 photos
-- -----------------------------------------------------------
-- Four images from this listing showed a bread loaf rather than the
-- chick. Same seller, different product. Dropped.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa7f38963250a4065864ec760d5da62ce2.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S498599e2d9ba4b4e8cd93a8003534456d.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sebd393972c80418b9f21f636ad0588f7F.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S9f1b5e31301b47f797ddb70bb085b96du.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S4b652c3dcd474c25acff209ae2e2d9830.png'
] where sku = 'sq-088';


-- -----------------------------------------------------------
-- sq-089 · Giant Butter Stick                       9 photos
-- -----------------------------------------------------------
-- The best-photographed product of this batch.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc3d452eee932471dbdb62fbe2a805d87O.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S3f49dd3fde434ec592a301cd92223642A.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1231e76136d1408d8735c2ed11e548ccP.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb032f95b59c143c28b4fd9e12a50e579r.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sc0b4f63221c149eaa1217dc117d7237fH.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Se5905de6b9ea4c548a4996772625e554y.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb6cb8c93339e41d0b426e53ed3bcc73cY.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S789bd4c6fee34bfcb0a3d3d4550fd30ea.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S880ca73a03cd402eaa26b7951a3353a6k.jpg'
] where sku = 'sq-089';


-- -----------------------------------------------------------
-- sq-090 · Chubby Banana Squish                     5 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S699e443cb74a41ca88e075417dafbd59n.jpeg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sba2493d7bf51462d87c0a85b22007a12A.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sa20a5c92d2914841bb8d5f2afe87a6fc1.png',
  'https://ae-pic-a1.aliexpress-media.com/kf/S14d48da2b45e4cd4b4c08f9e6230f4ff2.jpeg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sec7ec09d233440ebb3906883d1c226e2y.jpeg'
] where sku = 'sq-090';


-- -----------------------------------------------------------
-- sq-091 · Big Peanut Squish                        6 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/S9762be39937846efa5f3382327834ccfz.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S760b9d3153594148ab4f14794c1f1018y.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd216e780bf4b4a2090d1284dfdee27beN.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sf84069fdb723462aa9b314f7d68c5dcbI.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S523cf5f7a4cd4dbfb293ed679081eb001.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S6635b2a42a7747edb8b0f02f73a54f60z.jpg'
] where sku = 'sq-091';


-- -----------------------------------------------------------
-- sq-092 · Jumbo Pickle Squish                      3 photos
-- -----------------------------------------------------------
-- ⚠️ WORST RESULT OF THE BATCH, and it says something useful.
-- Six of this listing's nine images show a banana, a carrot or a
-- peanut — not a pickle. It is a multi-product seller reusing one
-- listing, which is exactly why this product was already parked as
-- Research over its completely empty review record. Treat three real
-- photos as confirmation of that call, not as bad luck.
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sd4885fb1df344596a37d817f6f6861fc4.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sbd60e2f281874addbd1790be76603d479.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S72235567e7ca4a239f1167e179ec216cG.jpg'
] where sku = 'sq-092';


-- -----------------------------------------------------------
-- sq-094 · Cream Strawberry Jumbo                   9 photos
-- -----------------------------------------------------------
update products set gallery = array[
  'https://ae-pic-a1.aliexpress-media.com/kf/Sb1044a3b722c4610882d4dcb8f0d0429z.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sfdbea2a5f8304e9cbfa68ce555f9ec9dI.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sca73221969a94f1591a57a27b74fd04d0.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S185038188180424db102990d073dd2b4X.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S7876f25b753a4640b80075f0d0491cf6d.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Scb7e8b8cd3674d3ca4a03d16425eb44bL.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/Sf23e6f92ff3c48c6942859552d817c5eb.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S1f2c70703c4f4ad884b33dbf90de7f23E.jpg',
  'https://ae-pic-a1.aliexpress-media.com/kf/S3a54e6068aa6440aa8a78ccca6e3aa87M.jpg'
] where sku = 'sq-094';

commit;


-- ===========================================================
-- CHECK IT WORKED
-- ===========================================================
--   select sku, name, status, coalesce(array_length(gallery,1),0) as photos
--   from products where sku between 'sq-065' and 'sq-075' order by sku;
--
-- And, across everything, what still has fewer than four photos:
--   select sku, name, coalesce(array_length(gallery,1),0) as photos
--   from products where coalesce(array_length(gallery,1),0) < 4 order by sku;
-- ===========================================================
