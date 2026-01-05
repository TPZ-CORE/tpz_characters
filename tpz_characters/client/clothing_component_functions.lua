
local metaPedCategoryTags = {
    Tags = {
        [`accessories`]         = "accessories",
        [`ammo_pistols`]        = "ammo_pistols",
        [`ammo_rifles`]         = "ammo_rifles",
        [`ankle_bindings`]      = "ankle_bindings",
        [`aprons`]              = "aprons",
        [`armor`]               = "armor",
        [`badges`]              = "badge",
        [`beards_chin`]         = "beards_chin",
        [`beards_chops`]        = "beards_chops",
        [`beards_complete`]     = "beards_complete",
        [`beards_mustache`]     = "beards_mustache",
        [`belts`]               = "belts",
        [`belt_buckles`]        = "buckle",
        [`bodies_lower`]        = "boots",
        [`bodies_upper`]        = "bodies_upper",
        [`boots`]               = "boots",
        [`boot_accessories`]    = "spurs",
        [`chaps`]               = "chap",
        [`cloaks`]              = "cloak",
        [`coats`]               = "coat",
        [`coats_closed`]        = "coatclosed",
        [`coats_heavy`]         = "coats_heavy",
        [`dresses`]             = "dress",
        [`eyebrows`]            = "eyebrows",
        [`eyes`]                = "eyes",
        [`eyewear`]             = "eyewear",
        [`gauntlets`]           = "gauntlets",
        [`gloves`]              = "glove",
        [`gunbelt_accs`]        = "gunbeltaccs",
        [`gunbelts`]            = "gunbelt",
        [`hair`]                = "hair",
        [`hair_accessories`]    = "hair_accessories",
        [`hats`]                = "hat",
        [`heads`]               = "heads",
        [`holsters_crossdraw`]  = "holsters_crossdraw",
        [`holsters_knife`]      = "holsters_knife",
        [`holsters_left`]       = "holster",
        [`holsters_right`]      = "holsters_right",
        [`jewelry_bracelets`]   = "vracelet",
        [`jewelry_rings_left`]  = "ringlh",
        [`jewelry_rings_right`] = "ringrh",
        [`loadouts`]            = "loadouts",
        [`masks`]               = "mask",
        [`masks_large`]         = "masks_large",
        [`neckties`]            = "neckties",
        [`neckwear`]            = "neckwear",
        [`outfits`]             = "outfits",
        [`pants`]               = "pant",
        [`ponchos`]             = "poncho",
        [`satchels`]            = "satchels",
        [`shirts_full`]         = "shirt",
        [`skirts`]              = "skirt",
        [`spats`]               = "spats",
        [`suspenders`]          = "suspenders",
        [`teeth`]               = "teeth",
        [`vests`]               = "vest",
        [`wrist_bindings`]      = "wrist_bindings",
    },
}


local textureId = -1

-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

local function GetMetaPedAssetGuids(ped, index)
    return Citizen.InvokeNative(0xA9C28516A6DC9D56, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function GetMetaPedAssetTint(ped, index)
    return Citizen.InvokeNative(0xE7998FEC53A33BBE, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function GetComponentIndexByCategory(ped, category)
    local modules = exports.tpz_core:getCoreAPI().modules()

    ped = ped or PlayerPedId()
    local numComponents = modules.GetNumComponentsInPed(ped)
    for i = 0, numComponents - 1, 1 do
        local componentCategory = modules.GetCategoryOfComponentAtIndex(ped, i)

        if metaPedCategoryTags.Tags[componentCategory] == category then
            return i
        end
    end
    return nil
end

local function SetTextureOutfitTints(ped, category, data)
    local palette = Config.clothesPalettes[data.palette]
    Citizen.InvokeNative(0x4EFC1F8FF1AD94DE, ped, joaat(category), palette, data.tint0, data.tint1, data.tint2)
end

local function GetGender()
    local Gender = IsPedMale(PlayerPedId()) and "Male" or "Female"
    return Gender
end


local function ResetPedComponents(ped)
    Citizen.InvokeNative(0x8507BCB710FA6DC0, ped or PlayerPedId())
end

---Remove all meta tags from ped
local function RemoveAllMetaTags(ped)
    local modules = exports.tpz_core:getCoreAPI().modules()

	for _, tag in pairs(Config.ComponentCategories) do
		RemoveTagFromMetaPed(ped, tag)
		modules.UpdatePedVariation(ped)
	end
end

-- if values are 0 then we need to make everything same color
local function SetDefaultSkin(gender, skin)
    gender = gender == 'mp_male' and 'M' or 'F'

	for _, value in pairs(Config.DefaultChar) do
		local albedo = joaat(value.Albedo[1]:format(gender))
		if albedo == skin.albedo then
			-- work arround to fix Torso
			for _, v in pairs(value.Body) do

				if skin.torso and skin.torso > 0 then
					if joaat(v:format(gender)) ~= skin.torso then
						skin.torso = joaat(v:format(gender))
						break
					end
				end
			end

			if skin.headtype and skin.headtype == 0 then
				skin.headtype = joaat(value.Heads[1]:format(gender))
			end

			if skin.bodytype and skin.bodytype == 0 then
				skin.bodytype = joaat(value.Body[1]:format(gender))
			end

			if skin.legstype and skin.legstype == 0 then
				skin.legstype = joaat(value.Legs[1]:format(gender))
			end

			if skin.torso and skin.torso == 0 then
				skin.torso = joaat(value.Body[1]:format(gender))
			end
			break
		end
	end

	return skin
end

local function LoadFaceFeatures(ped, skin)
	for _, value in pairs(Config.FaceFeatures) do
		for _, v in pairs(value) do
			if skin[v.comp] and skin[v.comp] ~= 0 then
				SetCharExpression(ped, v.hash, skin[v.comp])
			end
		end
	end
end

local function ApplyAllComponents(category, value, ped, set)
    local modules = exports.tpz_core:getCoreAPI().modules()

    local Clothing = GetClothing()
    local Groom    = GetGroom()

    if Clothing == nil or exports.tpz_core:getCoreAPI().GetTableLength(Clothing) <= 0 then
        Clothing = LoadClothingData()
    end

    if Groom == nil or exports.tpz_core:getCoreAPI().GetTableLength(Groom) <= 0 then
        Groom = LoadGroomData()
    end

    while Clothing == nil or Groom == nil do
        Wait(100)
    end

    if value.palette ~= nil and value.id ~= 0 then

        local outfitHash = Clothing[category][value.id][value.palette].hex

        local status = not set and "false" or GetResourceKvpString((tostring(outfitHash)):format(CHARID or 0))
        if status == "true" then
            return RemoveTagFromMetaPed(ped, Config.ComponentCategories[category])
        end
    
       modules.ApplyShopItemToPed(outfitHash, ped)
    
        if category ~= "boots" then
            UpdateShopItemWearableState(outfitHash, `base`)
        end
    
        Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
        modules.UpdatePedVariation(ped)
        modules.IsPedReadyToRender(ped)
    
        if value.palette ~= 0 then
    
            local TagData = GetMetaPedData(category, ped)
    
            if TagData then
                local palette = Config.clothesPalettes[value.palette]
                local tint0   = (value.tint0 ~= 0) and value.tint0 or TagData.tint0
                local tint1   = (value.tint1 ~= 0) and value.tint1 or TagData.tint1
                local tint2   = (value.tint2 ~= 0) and value.tint2 or TagData.tint2
    
                SetMetaPedTag(ped, TagData.drawable, TagData.albedo, TagData.normal, TagData.material, palette, tint0, tint1, tint2)
            end
            
        end

    elseif value.palette == nil then -- groom

        if value.id > 0 then 

			local hash = Groom[category][value.id][value.color].hex

			modules.ApplyShopItemToPed(hash, ped)
		else
			local capitalizedCategoryName = exports.tpz_core:getCoreAPI().Capitalize(category)
			RemoveTagFromMetaPed(ped, Config.ComponentCategories[capitalizedCategoryName])
		end

    end
end

local function LoadComps(ped, components, set)
    local modules = exports.tpz_core:getCoreAPI().modules()

	for category, value in pairs(components) do

        -- We check if comp is a cloth.
        if value.palette ~= nil and value.tint0 ~= nil and value.tint01 ~= nil and value.tint02 ~= nil then
            ApplyAllComponents(category, value, ped, set)
        end

	end

	ApplyAllComponents("shirt", components.shirt, ped, set)
	ApplyAllComponents("vest", components.vest, ped, set)
	ApplyAllComponents("boots", components.boots, ped, set)

	modules.UpdatePedVariation(ped)
end

local GetBodyFeaturesHashByCompName = function(comp_type)

	for _, data in pairs (Config.FaceFeatures) do 

        for _, element in pairs (data) do

            if comp_type == element.comp then
                return element.hash
            end

        end

	end

	return nil
end

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

function LoadGroomData(gender)

    local Groom = {}

    local hairComponents = exports.tpz_core:getCoreAPI().modules().file.load("component.data.playerHairComponents")

    while hairComponents == nil do 
        Wait(100)
    end

    local gender = gender or GetGender()

    for category, value in pairs(hairComponents[gender]) do

        local categoryTable = {}

        for _, v in ipairs(value) do

            local typeTable = {}

            for _, va in ipairs(v) do
                table.insert(typeTable, { hex = va.hash })
            end

            table.insert(categoryTable, typeTable)
        end

        Groom[category] = categoryTable
    end
   
    return Groom

end

function LoadClothingData(gender)

    local Clothing = {}

    local playerComponents = exports.tpz_core:getCoreAPI().modules().file.load("component.data.playerComponents")

    while playerComponents == nil do 
        Wait(100)
    end
    
    local gender = gender or GetGender()

    for category, value in pairs(playerComponents[gender]) do

        local categoryTable = {}

        for _, v in ipairs(value) do

            local typeTable = {}

            for _, va in ipairs(v) do
                table.insert(typeTable, { hex = va.hash, remove = va.remove, showSkin = va.showSkin or false, needsFix = va.needsFix or false })
            end

            table.insert(categoryTable, typeTable)
        end


        Clothing[category] = categoryTable
    end
   
    return Clothing
end

function ApplyOverlay(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk, palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var, opacity, albedo, ped)

    ped = ped or PlayerPedId()

    for k, v in pairs(Config.overlay_all_layers) do
        if v.name == name then
            v.visibility = visibility
            if visibility ~= 0 then
                v.tx_normal = tx_normal
                v.tx_material = tx_material
                v.tx_color_type = tx_color_type
                v.tx_opacity = tx_opacity
                v.tx_unk = tx_unk
                if tx_color_type == 0 then
                    v.palette = Config.color_palettes[name][palette_id]
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    if tx_id ~= 0 then
                        v.tx_id = Config.overlays_info[name][1].id
                    end
                else
                    v.var = 0
                    if tx_id ~= 0 then
                        v.tx_id = Config.overlays_info[name][tx_id].id
                    end
                end
                v.opacity = opacity
            end
        end
    end

    local gender = GetGender()
    local current_texture_settings = Config.texture_types[gender]

    if textureId ~= -1 then
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId)
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId)
    end

    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, current_texture_settings.normal, current_texture_settings.material)

    for k, v in pairs(Config.overlay_all_layers) do
        if v.visibility ~= 0 then
            local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity, v.tx_unk)
            if v.tx_color_type == 0 then
                Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette)
                Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary, v.palette_color_secondary, v.palette_color_tertiary)
            end

            Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var);
            Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity);
        end
    end

    while not Citizen.InvokeNative(0x31DC8D3F216D8509, textureId) do
        Citizen.Wait(0)
    end

    Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId)
    Citizen.InvokeNative(0x0B46E25761519058, ped, joaat("heads"), textureId)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

function ApplyDefaultClothing()
    local modules    = exports.tpz_core:getCoreAPI().modules()

    local ped        = ped
    local isPedMale  = IsPedMale(ped)

    local numComponents = modules.GetNumComponentsInPed(ped)
    local componentsWithWearableState = {}
    for componentIndex = 0, numComponents - 1, 1 do
        local componentHash = modules.GetComponentAtIndex(ped, componentIndex, true)
        if componentHash ~= 0 then
            local numWearableStates = Citizen.InvokeNative(0xFFCC2DB2D9953401, componentHash, not isPedMale, true, Citizen.ResultAsInteger())
            if numWearableStates > 0 then
                local wearableStates = { `base` }
                for wearableStateIndex = 0, numWearableStates - 1, 1 do
                    local wearableState = Citizen.InvokeNative(0x6243635AF2F1B826, componentHash, wearableStateIndex, not isPedMale, true, Citizen.ResultAsInteger())
                    if wearableState ~= 0 then
                        table.insert(wearableStates, wearableState)
                    end
                end

                table.insert(componentsWithWearableState,
                    {
                        componentHash = componentHash,
                        componentCategory = modules.GetCategoryOfComponentAtIndex(ped, componentIndex),
                        wearableStates = wearableStates
                    })
            end
        end
    end

    if #componentsWithWearableState < 1 then
        return print("no components with wearable state")
    end

    local Helper = {
        pant = `pants`,
        shirt = `shirts_full`,
        boots = `boots`,
        bunbelt = `gunbelts`,
        holster = `holsters_left`,
        belt = `belts`,
        hair = `hair`,
        eyebrows = `eyebrows`,
        belts = `belts`,
    }

    local PlayerSkin         = GetPlayerSkinData()
    local PlayerTrackingData = GetPlayerTrackingData()

    for category, _ in pairs(PlayerSkin) do

        for _, component in ipairs(componentsWithWearableState) do

            if Helper[category] and Helper[category] == component.componentCategory then

                PlayerSkin[category] = component.componentHash

                if not PlayerTrackingData[category] then
                    PlayerTrackingData[category] = {}
                    PlayerTrackingData[category][component.componentHash] = { tint0 = 0, tint1 = 0, tint2 = 0, palette = 0 }
                end
            end
        end
    end

    --CachedComponents.Gunbelt = { comp = isPedMale and 795591403 or 1511461630, tint0 = 0, tint1 = 0, tint2 = 0, palette = 0 }
end


function GetComponentsWithWearableState(category, isMultiplayer)
    local modules = exports.tpz_core:getCoreAPI().modules()
    local ped = PlayerPedId()
    local numComponents = modules.GetNumComponentsInPed(ped)
    if not numComponents or numComponents < 1 then
        return `base`, nil
    end
    for componentIndex = 0, numComponents - 1, 1 do
        local componentHash = modules.GetComponentAtIndex(ped, componentIndex, isMultiplayer)
        local componentCategory = modules.GetCategoryOfComponentAtIndex(ped, componentIndex)
        if componentHash ~= 0 and metaPedCategoryTags.Tags[componentCategory] == category then
            local wearableStates = `base`
            return wearableStates, componentHash
        end
    end

    return `base`, nil
end

function GetMetaPedData(category, ped)
    local playerPed = ped or PlayerPedId()
    local componentIndex = GetComponentIndexByCategory(playerPed, category)
    if not componentIndex then
        return nil
    end
    local drawable, albedo, normal, material = GetMetaPedAssetGuids(playerPed, componentIndex)
    local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(playerPed, componentIndex)

    return { drawable = drawable, albedo = albedo, normal = normal, material = material, palette = palette, tint0 = tint0, tint1 = tint1, tint2 = tint2 }
end

function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

function FixClothingProperlyOnCategorySelect(category, skinData, ped)
    local entityPed = ped or PlayerPedId()
    local PlayerSkin

    if skinData then 
        PlayerSkin = skinData
    else 
        PlayerSkin = GetPlayerSkinData()
    end

    local modules = exports.tpz_core:getCoreAPI().modules()

    Wait(100)

    modules.IsPedReadyToRender()

    if category == "gunbelt" then
        --toggleComp(Config.ComponentCategories.Holster, CachedComponents.Holster, key)
    end

    if category == "vest" and IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.shirt) then
        local item = PlayerSkin.shirt
        if item and item.drawable ~= 0 then
            SetTextureOutfitTints(entityPed, 'shirts_full', item)
        end
    end

    if category == 'shirt' and IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.vest) then
        local item = PlayerSkin.vest
        if item and item.drawable ~= 0 then
            SetTextureOutfitTints(entityPed, 'vests', item)
        end
    end

    if category == "coat" or category == 'coatclosed' then

        if IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.vest) then
            local item = PlayerSkin.vest
            if item and item.drawable ~= 0 then
                SetTextureOutfitTints(entityPed, 'vests', item)
            end
        end

        if IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.shirt) then
            local item = PlayerSkin.shirt
            if item and item.drawable ~= 0 then
                SetTextureOutfitTints(entityPed, 'shirts_full', item)
            end
        end

    end

    if category == "boots" then
        if IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.boots) then
            local item = PlayerSkin.boots

            if item and item.drawable ~= 0 then
                SetTextureOutfitTints(entityPed, 'boots', item)
            end

        end

        if IsMetaPedUsingComponent(entityPed, Config.ComponentCategories.pant) then

            local item = PlayerSkin.pant

            if item and item.drawable ~= 0 then
                SetTextureOutfitTints(entityPed, 'pants', item)
            end

        end
    end

    if category == "pant" then 

        UpdateShopItemWearableState(Config.ComponentCategories[category], `base`) -- -2081918609
        modules.UpdatePedVariation(entityPed)

        local item = PlayerSkin.Shirt -- some pants breaking the shirt colors
        if item and item.drawable ~= 0 then
            SetTextureOutfitTints(entityPed, 'shirts_full', item)
        end

    end

end

function LoadAll(gender, ped, skinComp, set)
    local modules = exports.tpz_core:getCoreAPI().modules()

	RemoveAllMetaTags(ped)

	modules.IsPedReadyToRender(ped)
	ResetPedComponents(ped)

    modules.ApplyShopItemToPed(skinComp.headtype, ped)
	modules.ApplyShopItemToPed(skinComp.bodytype, ped)
	modules.ApplyShopItemToPed(skinComp.legstype, ped)

	modules.ApplyShopItemToPed(skinComp.eyes, ped)

    EquipMetaPedOutfit(ped, skinComp.waist)
	EquipMetaPedOutfit(ped, skinComp.body)

	modules.UpdatePedVariation(ped)
end

function LoadEntityComponents(ped, model, skinComp, reload, clean, preventVisibilityAdjustment)
	
    if not preventVisibilityAdjustment then
        SetEntityVisible(ped, false)
    end

    local skinComp = json.decode(skinComp)
	local gender      = model == "mp_male" and "Male" or "Female"
	local getPedModel = GetEntityModel(ped)

    local modules = exports.tpz_core:getCoreAPI().modules()

	if reload or getPedModel ~= joaat("mp_female") and getPedModel ~= joaat("mp_male") then

        LoadModel(model)
        
		SetPlayerModel(PlayerId(), model, false)
        SetModelAsNoLongerNeeded(joaat(model))
		SetModelAsNoLongerNeeded(joaat(model))
    end
    
    modules.IsPedReadyToRender(ped)

	if model ~= "mp_male" then
		modules.EquipMetaPedOutfitPreset(ped, 7)
	else
		modules.EquipMetaPedOutfitPreset(ped, 4)
	end

    modules.EquipMetaPedOutfitPreset(ped, 3)
	modules.UpdatePedVariation(ped)

    LoadAll(gender, ped, skinComp, true)

    if skinComp['ageing'] then
        ApplyOverlay("ageing", skinComp['ageing'].visibility, skinComp['ageing'].id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, skinComp['ageing'].opacity, skinComp.albedo, ped)
    end

    -- Load lifestyle
    local lifestyle_elements = {
        "moles",
        "spots",
        "complex",
        "acne",
        "freckles",
        "disc",
        "scars",
        "grime",
    }

    for _, element in pairs (lifestyle_elements) do 

        if skinComp[element] then

            local data = skinComp[element]

            local color     = element == "grime" and 1 or 0
            local colortype = element == "grime" and 0 or 1

            ApplyOverlay(string.lower(element), data.visibility, 
            data.id, 0, 0, 
            colortype, 1.0, 0, color, 0, 0, 0, 1, 
            data.opacity, skinComp.albedo, ped)

        end

    end

    -- Load Body Features 
    local body_feature_elements = {
        "jaw",
        "chin", 
        "head", 
        "nose", 
        "ears", 
        "mouthandlips", 
        "cheek", 
        "eyesandbrows", 
        "upperbody", 
        "lowerbody",
        "headsize",
        "facew",
        "faced",
        "faces",
        "neckw",
        "neckd",

        "eyebrowh",
        "eyebroww",
        "eyebrowd",
        "eyed",
        "eyeang",
        "eyedis",
        "eyeh",
        "eyelidh",
        "eyelidw",
        "eyelidl",
        "eyelidr",
        
        "earsw",
        "earsa",
        "earsh",
        "earsd",
        
        "cheekbonesh",
        "cheekbonesw",
        "cheekbonesd",
        
        "jawh",
        "jaww",
        "jawd",
        
        "chinh",
        "chinw",
        "chind",
        
        "nosew",
        "noses",
        "noseh",
        "noseang",
        "nosec",
        "nosedis",
        
        "mouthw",
        "mouthd",
        "mouthx",
        "mouthy",
        "uliphh",
        "uliphw",
        "uliphd",
        "lliphh",
        "lliphw",
        "lliphd",
        "mouthclw",
        "mouthcrw",
        "mouthcld",
        "mouthcrd",
        "mountclh",
        "mouthcrh",
        "mouthclld",
        "mouthcrld",
        
        "armss",
        "shoulderss",
        "shoulderst",
        "shouldersm",
        "chests",
        "waistw",
        "hipss",
        
        "legss",
        "calvess",
    }

    for _, element in pairs (body_feature_elements) do 

        if skinComp[element] then

            local data = skinComp[element]

            data.id = data.id == -1 and -1.0 or data.id
            data.id = data.id == 1 and 1.0 or data.id

            local hash = GetBodyFeaturesHashByCompName(element)
            modules.IsPedReadyToRender(ped)
            SetCharExpression(ped, hash, value)
            modules.UpdatePedVariation(ped)
        end

    end

    -- Load Groom
    local groom = LoadGroomData(gender)

    local groom_elements = {
        'hair',
        'overlay',
        'hair_overlay',
        'beard',
        'beardstabble',
        'bow',
        'eyebrows',
    }

    for _, element in pairs (groom_elements) do 

        if skinComp[element] ~= nil then

            local data = skinComp[element]

            if element == 'hair' or element == 'bow' or element == 'beard' then

                modules.IsPedReadyToRender(ped)

                if data.id > 0 then 

                    local hash = groom[element][data.id][data.color].hex
        
                    modules.ApplyShopItemToPed(hash, ped)
                end
        
                modules.UpdatePedVariation(ped)

            else

                if element == 'overlay' or element == 'hair_overlay' then 
                    element = 'hair'
                end

                ApplyOverlay(element, data.visibility,
                data.id, 1, 0, 0, 1.0, 0, 1, 
                data.color, 0, 0, 1,
                data.opacity, skinComp.albedo, ped)
            end

        else

            print(element)
            if element == 'hair' then

                modules.IsPedReadyToRender(ped)

                local hash = groom['hair'][1][1].hex
        
                modules.ApplyShopItemToPed(hash, ped)
        
                modules.UpdatePedVariation(ped)

            elseif element == 'eyebrows' or element == 'hair_overlay' then

                if element == 'overlay' or element == 'hair_overlay' then 
                    element = 'hair'
                end

                ApplyOverlay(element, 1,
                1, 1, 0, 0, 1.0, 0, 1, 
                1, 0, 0, 1,
                1.0, skinComp['albedo'], ped)
            end

            if element == 'beardstabble' and model == "mp_female" then 
                ApplyOverlay('beardstabble', 0, 1, 1, 0, 0, 1.0, 0, 1, 0, 0, 0, 1, 0.0, skinComp['albedo'])
	
            end

        end


    end

    -- Load Makeup
    local makeup_elements = {
        'foundation',
        'lipsticks',
        'shadows',
        'eyeliners',
        'blush',
    }

    for _, element in pairs (makeup_elements) do 

        if skinComp[element] then
            local data = skinComp[element]

            ApplyOverlay(element, data.visibility,
            data.id, 1, 0, 0,
            1.0, 0, 1, data.primary_color, data.secondary_color or 0,
            data.tertiary_color or 0, data.variant or 1,
            data.opacity, skinComp.albedo, ped)

        end
        
    end

    local clothing = LoadClothingData(gender)

    for _, cloth in pairs (Config.ClothingCategories) do

        if skinComp[cloth.category] then

            local data = skinComp[cloth.category]

            if data.id ~= 0 then

                local outfitHash = clothing[cloth.category][data.id][data.palette].hex
    
                modules.IsPedReadyToRender(ped)
                modules.ApplyShopItemToPed(outfitHash, ped)

                if data.drawable ~= 0 then
                    local palette = Config.clothesPalettes[data.palette]
                    
                    SetMetaPedTag(ped, data.drawable, data.albedo, data.normal, data.material, palette, data.tint0, data.tint1, data.tint2)
                end
    
                modules.UpdatePedVariation(ped)
                
                FixClothingProperlyOnCategorySelect(cloth.category, skinComp, ped)

            else
                modules.IsPedReadyToRender(ped)
                RemoveTagFromMetaPed(ped, Config.ComponentCategories[cloth.category])
                modules.UpdatePedVariation(ped)

            end
    

        end

    end

    RemoveTagFromMetaPed(ped, Config.ComponentCategories.ammopistol)
	SetPedScale(ped, skinComp.scale)
    Wait(150) -- mandatory wait

    if clean then
        CleanPlayerPed()
    end

    if not preventVisibilityAdjustment then
        SetEntityVisible(ped, true)
        SetEntityFadeIn(ped)
    end
end




