-----------------------------------------------------------
--[[ Variables ]]--
-----------------------------------------------------------

local delays = {}
local isRefreshing = false

-----------------------------------------------------------
--[[ Data ]]--
-----------------------------------------------------------

cache.component = { color = {} }

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


-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

local invokeNative = Citizen.InvokeNative
local function SetTextureOutfitTints(ped, category, palette, tint0, tint1, tint2)
  if not palette then return end
  if palette == 0 then return end
  return invokeNative(0x4EFC1F8FF1AD94DE, ped, Components.getCategoryHash(category), GetHashFromString(palette), tint0, tint1,
    tint2)
end
local function SetActiveMetaPedComponentsUpdated(ped) return invokeNative(0xAAB86462966168CE, ped, true) end
local function N_0x704C908E9C405136(ped) return invokeNative(0x704C908E9C405136, ped) end
local function GetShopItemBaseLayers(hash, metapedType, isMp)
  return invokeNative(0x63342C50EC115CE8,
    GetHashFromString(hash), 0, 0, metapedType, isMp, Citizen.PointerValueInt(), Citizen.PointerValueInt(),
    Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(),
    Citizen.PointerValueInt(), Citizen.PointerValueInt())
end
local function UpdatePedVariation(ped) return invokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) end
local function IsPedReadyToRender(...) return invokeNative(0xA0BC8FAED8CFEB3C, ...) end
local function IsThisModelAHorse(...) return invokeNative(0x772A1969F649E902, ...) == 1 end
local function ApplyShopItemToPed(ped, hash, immediatly, isMp, p4)
  return invokeNative(0xD3A7B003ED343FD9, ped,
    GetHashFromString(hash), immediatly, isMp, p4)
end
local function GetMetaPedAssetTint(ped, index)
  return invokeNative(0xE7998FEC53A33BBE, ped, index,
    Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
end
local function GetNumComponentsInPed(ped) return invokeNative(0x90403E8107B60E81, ped) or 0 end
local function GetShopItemComponentCategory(...) return invokeNative(0x5FF9A878C3D115B8, ...) end
local function UpdateShopItemWearableState(ped, hash, state)
  return invokeNative(0x66B957AAC2EAAEAB, ped, GetHashFromString(hash), GetHashFromString(state), 0, true, 1)
end
local function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
  return invokeNative(
    0xBC6DF00D7A4A6819, ped, GetHashFromString(drawable), GetHashFromString(albedo), GetHashFromString(normal),
    GetHashFromString(material), GetHashFromString(palette), tint0, tint1, tint2)
end

local function refreshPed(ped)
  SetActiveMetaPedComponentsUpdated(ped)
  UpdatePedVariation(ped)
  N_0x704C908E9C405136(ped)
end

local function GetCategoryOfComponentAtIndex(ped, componentIndex)
  local pedType = IsThisModelAHorse(GetEntityModel(ped)) and 6 or 0
  local category = invokeNative(0x9b90842304c938a7, ped, componentIndex, pedType, Citizen.ResultAsInteger())
  --patch neckerchiefs
  if category == `neckerchiefs` then
    category = `neckwear`
  end
  return category
end

--- @return integer (Hash)
--- @return integer (WearableState)
local function GetShopItemComponentAtIndex(ped, index)
  local componentHash, a, wearableState = GetShopPedComponentAtIndex(ped, index, true, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
  if not componentHash or componentHash == 0 then
    componentHash, a, wearableState = GetShopPedComponentAtIndex(ped, index, false, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
  end
  return componentHash, wearableState
end


local function isValidValue(value)
  return value and value ~= 0 and value ~= -1 and value ~= 1
end

---@return any data formatted table for component data
local function formatComponentData(_data)
  local data = table.copy(_data)
  if type(data) ~= "table" then
    data = { hash = data }
  end
  if type(data.hash) == "table" then data = data.hash end --for VORP
  if data.hash == 0 or data.hash == false then
    data.remove = true
  end
  data.hash = isValidValue(data.hash) and data.hash or nil
  data.drawable = isValidValue(data.drawable) and data.drawable or nil
  data.palette = isValidValue(data.palette) and data.palette or nil

  if not data.hash and not data.drawable and not data.palette and not data.remove then
    return false
  end
  return data
end

local function getComponentIndexOfCategory(ped, category)
  category = Components.getCategoryHash(category)
  local numComponent = GetNumComponentsInPed(ped)
  for index = 0, numComponent - 1, 1 do
    if GetCategoryOfComponentAtIndex(ped, index) == category then
      return index
    end
  end
  return -1
end

function Component.new(index, category, hash, wearableState, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
  return {
    category = Components.getCategoryNameFromHash(category),
    categoryHash = Components.getCategoryHash(category),
    palette = palette,
    tint0 = tint0,
    tint1 = tint1,
    tint2 = tint2,
    hash = hash,
    wearableState = Components.getWearableStateNameFromHash(wearableState),
    wearableStateHash = GetHashFromString(wearableState) or false,
    index = index,
    drawable = drawable,
    albedo = albedo,
    normal = normal,
    material = material,
  }
end

local function getComponentAtIndex(ped, index)
  local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, index)
  local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, index)
  local category = GetCategoryOfComponentAtIndex(ped, index)

  local hash, wearableState = GetShopItemComponentAtIndex(ped, index)
  return Component.new(index, category, hash, wearableState, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

--- A function to get the base layer of a component
---@param ped integer (The entity ID or the metaped type)
---@param hash string|integer (The component hash)
---@param inTable? boolean (`true` to get the result as a table, `false` to get the result as separate values<br> Default: `false`)
---@return table|integer,integer,integer,integer,integer,integer,integer,integer (When inTable is true: returns a table with {drawable, albedo, normal, material, palette, tint0, tint1, tint2} <br> When inTable is false: 1st: drawable <br> 2nd: albedo <br> 3rd: normal <br> 4th: material <br> 5th: palette <br> 6th: tint0 <br> 7th: tint1 <br> 8th: tint2)
function Components.getBaseLayer(ped, hash, inTable)
  inTable = GetValue(inTable, false)
  local metapedType = DoesEntityExist(ped) and GetMetaPedType(ped) or ped
  local drawable, albedo, normal, material, palette, tint0, tint1, tint2 = GetShopItemBaseLayers(hash, metapedType, Components.isMpComponent(ped, hash))
  if drawable == 0 or drawable == 1 then drawable = nil end
  if albedo == 0 then albedo = nil end
  if normal == 0 then normal = nil end
  if material == 0 then material = nil end
  if palette == 0 then palette = nil end
  if inTable then
    return {
      drawable = drawable,
      albedo = albedo,
      normal = normal,
      material = material,
      palette = Components.getPaletteNameFromHash(palette),
      tint0 = tint0,
      tint1 = tint1,
      tint2 = tint2
    }
  end
  return drawable, albedo, normal, material, Components.getPaletteNameFromHash(palette), tint0, tint1, tint2
end

local function convertToMetaTag(ped, data)
  data = table.copy(data)
  --restrict to hats & masks
  if not data.hash then return data end
  if data.albedo then return data end

  local drawable, albedo, normal, material, palette, tint0, tint1, tint2 = Components.getBaseLayer(ped, data.hash)
  data.drawable = data.drawable or drawable or data.hash or 0
  data.albedo = data.albedo or albedo or 0
  data.normal = data.normal or normal or 0
  data.material = data.material or material or 0
  data.palette = data.palette or palette or 0
  data.tint0 = data.tint0 or tint0
  data.tint1 = data.tint1 or tint1
  data.tint2 = data.tint2 or tint2
  data.hash = nil
  return data
end

local function applyDefaultBodyParts(ped)
  if IsPedMale(ped) then
    EquipMetaPedOutfitPreset(ped, 4, false)
    Components.apply(ped, "bodies_upper", `CLOTHING_ITEM_M_BODIES_UPPER_001_V_001`)
    Components.apply(ped, "bodies_lower", `CLOTHING_ITEM_M_BODIES_LOWER_001_V_001`)
    Components.apply(ped, "heads", `CLOTHING_ITEM_M_HEAD_002_V_001`)
    Components.apply(ped, "eyes", `CLOTHING_ITEM_M_EYES_001_TINT_001`)
    Components.apply(ped, "teeth", `CLOTHING_ITEM_M_TEETH_000`)
  else
    EquipMetaPedOutfitPreset(ped, 7, false)
    Components.apply(ped, "bodies_upper", `CLOTHING_ITEM_F_BODIES_UPPER_001_V_001`)
    Components.apply(ped, "bodies_lower", `CLOTHING_ITEM_F_BODIES_LOWER_001_V_001`)
    Components.apply(ped, "heads", `CLOTHING_ITEM_F_HEAD_002_V_001`)
    Components.apply(ped, "eyes", `CLOTHING_ITEM_F_EYES_001_TINT_001`)
    Components.apply(ped, "teeth", `CLOTHING_ITEM_F_TEETH_000`)
  end
end

---@param ped integer
---@param category string|integer
---@param hash table|integer|string
---@param state string|integer
local function updateComponentWearableState(ped, category, hash, state)
  category = Components.getCategoryNameFromHash(category)
  state = GetHashFromString(state)
  Entity(ped).state:set("wearableState:" .. category, state)
  UpdateShopItemWearableState(ped, type(hash) == "table" and hash.hash or hash, state)
end

-----------------------------------------------------------
--[[ Color Management ]]--
-----------------------------------------------------------

---@param ped integer (The entity ID)
---@param category integer|string the category hash
local function resetCachedColor(ped, category)
  if not cache.component.color[ped] then return end
  cache.component.color[ped][category] = nil
  if category == `neckwear` then
    cache.component.color[ped][`neckerchiefs`] = nil
  end
end

---@param ped integer (The entity ID)
---@param category integer (the category hash)
---@param hash integer (the component hash)
---@param wearableState integer (the wearable state)
---@param palette integer (the palette hash)
---@param tint0 integer
---@param tint1 integer
---@param tint2 integer
local function addCachedComponent(ped, index, category, hash, wearableState, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
  category = Components.getCategoryHash(category)
  table.addMultiLevels(cache.component.color, ped, category)
  cache.component.color[ped][category] = Component.new(index, category, hash, wearableState, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
  if category == `neckwear` then
    cache.component.color[ped][`neckerchiefs`] = table.copy(cache.component.color[ped][category])
    cache.component.color[ped][`neckerchiefs`].category = "neckerchiefs"
  elseif category == `neckerchiefs` then
    cache.component.color[ped][`neckwear`] = table.copy(cache.component.color[ped][category])
    jcache.component.color[ped][`neckwear`].category = "neckwear"
  end
end

---@param ped integer the entity ID
---@return table
local function initCachePedComponents(ped)
  while isRefreshing do Wait(0) end
  if not cache.component.color[ped] then
    local numComponent = GetNumComponentsInPed(ped)
    if not numComponent then return {} end -- No component detected on the ped
    for index = 0, numComponent - 1 do
      --Get current component
      local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(ped, index)
      local _, drawable, albedo, normal, material = GetMetaPedAssetGuids(ped, index)
      local category = GetCategoryOfComponentAtIndex(ped, index)

      local hash, wearableState = GetShopItemComponentAtIndex(ped, index)
      addCachedComponent(ped, index, category, hash, wearableState, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    end
  end
  return table.copy(cache.component.color[ped])
end

-----------------------------------------------------------
--[[ Cache Management ]]--
-----------------------------------------------------------

local function reapplyComponentStats(ped)
  for category, list in pairs(Components.data.wearableStates) do
    if Components.isCategoryAClothes(category) then
      local isEquiped, index = Components.isCategoryEquiped(ped, category)
      if isEquiped then
        local state = Entity(ped).state["wearableState:" .. category] or "base"
        local stateName = Components.getWearableStateNameFromHash(state)
        if stateName ~= "base" and table.includes(list, stateName) then
          local hash = GetShopItemComponentAtIndex(ped, index)
          if Config.Debug then
            print("Reapply state of %s: %s (%d)", category, Components.getWearableStateNameFromHash(state), state)
          end
          UpdateShopItemWearableState(ped, hash, state)
        end
      end
    end
  end
end

local function reapplyComponentsColor(ped)
  for i = 1, #Components.data.order do
    local category = Components.getCategoryHash(Components.data.order[i])
    if cache.component.color[ped][category] then
      local data = cache.component.color[ped][category]
      SetTextureOutfitTints(ped, category, data.palette, data.tint0, data.tint1, data.tint2)
    end
  end
end

local function reapplyCached(ped)
  if not cache.component.color[ped] then return end
  delays["refresh" .. ped] = timeout.delay("jo_libs:component:reapplyCachedColor" .. ped,
    function() component.waitPedLoaded(ped) end, function()
      refreshPed(ped)
      -- jo.component.waitPedLoaded(ped)
      reapplyComponentStats(ped)
      reapplyComponentsColor(ped)
      cache.component.color[ped] = nil
      refreshPed(ped)
    end)
end


