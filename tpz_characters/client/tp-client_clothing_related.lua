Components.data = {}

Components.data.pedCategories = {
  "heads",
  "eyes",
  "teeth",
  "bodies_upper",
  "bodies_lower",
  "hair",
  "beards_complete",
  "ponchos",
  "cloaks",
  "hair_accessories",
  "dresses",
  "gloves",
  "coats",
  "coats_closed",
  "vests",
  "suspenders",
  "neckties",
  "shirts_full",
  "spats",
  "gunbelts",
  "gauntlets",
  "holsters_left",
  "loadouts",
  "belt_buckles",
  "belts",
  "skirts",
  "boots",
  "pants",
  "boot_accessories",
  "accessories",
  "satchels",
  "jewelry_rings_right",
  "jewelry_rings_left",
  "jewelry_bracelets",
  "aprons",
  "chaps",
  "badges",
  "gunbelt_accs",
  "eyewear",
  "masks",
  "masks_large",
  "hats",
  "hair",
  "beards_complete",
  "teeth",
  "neckwear",
  "neckerchiefs",
  "armor",
}

Components.data.order = table.copy(Components.data.pedCategories)

local categoryNotClothes = {
  hair = true,
  beards_complete = true,
  teeth = true,
  heads = true,
  bodies_lower = true,
  bodies_upper = true,
  eyes = true,
  neckerchiefs = true
}

Components.data.pedClothes = table.filter(Components.data.pedCategories, function(cat) return not categoryNotClothes[cat] end)
Components.data.clothesCategories = {}

for i = 1, #Components.data.pedClothes do
  local category = Components.data.pedClothes[i]
  local hash = Components.getCategoryHash(category)
  Components.data.clothesCategories[hash] = category
end

Components.data.categoryName = {}

for i = 1, #Components.data.order do
  local category = Components.data.order[i]
  local hash = Components.getCategoryHash(category)
  Components.data.categoryName[hash] = category
end

Components.data.wearableStates = {
  shirts_full = {
    -- first digit for collar : 0 = closed/1 = opened
    -- second digit for sleeve : 0 = full/1 = rolled
    [00] = "base",
    [01] = "closed_collar_rolled_sleeve",
    [10] = "open_collar_full_sleeve",
    [11] = "open_collar_rolled_sleeve",
  },
  neckwear = {
    [0] = "base",   --down
    [1] = "mask_up" --up
  },
  boots = {
    [0] = "base",       --upper
    [1] = "under_pants" --under
  },
  loadouts = {
    [0] = "base",       --right
    [1] = "base_right", --left
  },
  vests = {
    [0] = "base",       --upper
    [1] = "under_pants" --under
  },
  hair = {
    [0] = "base",
    [1] = "pomade"
  },
  others = {
    "base_coat_open",
    "base_coat_open_glove",
    "base_glove",
    "base_vest",
    "base_vest_coat_open",
    "base_overalls",
    "base_overalls_coat_open",
    "open_collar_full_sleeve",
    "open_collar_full_sleeve_coat_open",
    "open_collar_full_sleeve_vest",
    "open_collar_full_sleeve_vest_coat_open",
    "open_collar_full_sleeve_overalls",
    "open_collar_full_sleeve_overalls_coat_open",
    "closed_collar_rolled_sleeve",
    "closed_collar_rolled_sleeve_vest",
    "closed_collar_rolled_sleeve_overalls",
    "open_collar_rolled_sleeve",
    "open_collar_rolled_sleeve_vest",
    "open_collar_rolled_sleeve_overalls",
    "gown",
    "base_tucked",
    "pomade_tucked",
    "tuck",
    "dummy",
    "stocking",
    "short_pants",
    "shirt_full_sleeve",
    "short_boots_under_pants",
    "under_boots",
    "under_spats",
    "under_chaps",
    "under_ripped_pants",
    "shirt_rolled_sleeve",
    "shirt_rolled_sleeve_archer_glove",
    "shirt_rolled_sleeve_gunslinger_glove",
    "shirt_rolled_sleeve_fingerless_glove",
    "shirt_rolled_sleeve_glove",
    "shirt_full_sleeve_archer_glove",
    "shirt_full_sleeve_gunslinger_glove",
    "shirt_full_sleeve_fingerless_glove",
    "shirt_full_sleeve_glove",
    "base_vest_coat_open_archer_glove",
    "base_vest_coat_open_gunslinger_glove",
    "base_vest_coat_open_fingerless_glove",
    "base_vest_coat_open_glove",
    "base_vest_gunslinger_glove",
    "base_vest_archer_glove",
    "base_vest_fingerless_glove",
    "base_vest_glove",
    "base_archer_glove",
    "base_gunslinger_glove",
    "base_fingerless_glove",
    "base_coat_open_archer_glove",
    "base_coat_open_gunslinger_glove",
    "base_coat_open_fingerless_glove",
    "shirt_009",
    "closed_collar_rolled_sleeve_vest_coat_open",
    "closed_collar_rolled_sleeve_coat_open",
  }
}

Components.data.wearableStatesName = {}

for category, states in pairs(Components.data.wearableStates) do
  for _, state in pairs(states) do
    Components.data.wearableStatesName[GetHashFromString(state)] = state
  end
end

Components.wearableStates = Components.data.wearableStates --deprecated name

Components.data.palettes = {
  "metaped_tint_animal",
  "metaped_tint_combined",
  "metaped_tint_combined_leather",
  "metaped_tint_combined_leather",
  "metaped_tint_eye",
  "metaped_tint_generic",
  "metaped_tint_generic_clean",
  "metaped_tint_generic_weathered",
  "metaped_tint_generic_worn",
  "metaped_tint_hair",
  "metaped_tint_hat",
  "metaped_tint_hat_clean",
  "metaped_tint_hat_weathered",
  "metaped_tint_hat_worn",
  "metaped_tint_horse",
  "metaped_tint_horse_leather",
  "metaped_tint_leather",
  "metaped_tint_makeup",
  "metaped_tint_mpadv",
  "metaped_tint_skirt_clean",
  "metaped_tint_skirt_weathered",
  "metaped_tint_skirt_worn",
}

Components.palettes = Components.data.palettes --deprecated name
Components.data.palettesName = {}

for i = 1, #Components.data.palettes do
  local palette = Components.data.palettes[i]
  local hash = GetHashFromString(palette)
  Components.data.palettesName[hash] = palette
end

Components.data.expressions = {
  cheekbonesDepth = 13709,
  cheekbonesHeight = 27147,
  cheekbonesWidth = 43983,
  chinDepth = 58147,
  chinHeight = 15375,
  chinWidth = 50098,
  earlobes = 60720,
  earsAngle = 46798,
  earsDepth = 49261,
  earsHeight = 10308,
  earsWidth = 49231,
  eyebrowDepth = 19153,
  eyebrowHeight = 13059,
  eyebrowWidth = 12281,
  eyelidHeight = 35627,
  eyelidLeft = 52902,
  eyelidRight = 22421,
  eyelidWidth = 7019,
  eyesAngle = 53862,
  eyesDepth = 60996,
  eyesDistance = 42318,
  eyesHeight = 56827,
  faceWidth = 41396,
  headWidth = 34006,
  jawDepth = 7670,
  jawHeight = 36106,
  jawWidth = 60334,
  jawY = 55182,
  mouthDepth = 43625,
  mouthWidth = 61541,
  mouthX = 31427,
  mouthY = 16653,
  noseAngle = 13489,
  noseCurvature = 61782,
  noseHeight = 1013,
  noseSize = 13425,
  noseWidth = 28287,
  nostrilsDistance = 22046,

  upperLipHeight = 6656,
  upperLipWidth = 37313,
  upperLipDepth = 50037,
  lowerLipHeight = 47949,
  lowerLipWidth = 45232,
  lowerLipDepth = 23830,
  mouthConerLeftWidth = 57350,
  mouthConerLeftDepth = 40950,
  mouthConerLeftHeight = 46661,
  mouthConerLeftLipsDistance = 22344,
  mouthConerRightHeight = 49299,
  mouthConerRightDepth = 9423,
  mouthConerRightWidth = 55718,
  mouthConerRightLipsDistance = 60292,

  arms = 46032,
  chest = 27779,
  hip = 49787,
  neckDepth = 60890,
  neckWidth = 36277,
  shoulderBlades = 18046,
  shoulders = 50039,
  shoulderThickness = 7010,
  waist = 50460,

  calves = 42067,
  thighs = 64834,
}
Components.expressions = Components.data.expressions --deprecated name
