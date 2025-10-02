local modules            = nil
local PlayerSkin         = {}
local PlayerTrackingData = {}

local PlayerFixClothing <const> = {}
SkinColorTracker = 1
HeadIndexTracker = 1
BodyTypeTracker = 1
LegsTypeTracker = 1
EyeColorIndexTracker = 14
TheethIndexTracker = 1

local Clothing = {}
local Groom    = {}

local IsDressed    = true

local SELECTED_CATEGORY_TYPE  = nil
Heading            = 0
-----------------------------------------------------------
--[[ First Creation ]]--
-----------------------------------------------------------

function GetPlayerSkinData()
	return PlayerSkin
end

function GetPlayerTrackingData()
	return PlayerTrackingData
end

function GetClothing()
	return Clothing
end

function GetGroom()
	return Groom
end

function CreateCharacterLobbyHandlers()

    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(1000)
    end

    DestroyAllCams(true)

    Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
            
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true)

    local instanced = GetPlayerServerId(PlayerId()) + 456565
	TriggerServerEvent('tpz_core:instanceplayers', math.floor(instanced)) 
    --riggerServerEvent('tpz_characters:SetPlayerAtCreatorStatus') 
    
    local CreatorData = Config.OnCharacterCreate

    exports.weathersync:setSyncEnabled(false)
	exports.weathersync:setMyWeather(CreatorData.Modifications.Weather.Type, CreatorData.Modifications.Weather.Transition,  CreatorData.Modifications.Weather.Snow)
	exports.weathersync:setMyTime(CreatorData.Modifications.ClockTime.Hour, 0, 0, CreatorData.Modifications.ClockTime.Transition, true)

    SetTimecycleModifier(CreatorData.Modifications.Timecycle.ModifierName)
	Citizen.InvokeNative(0xFDB74C9CC54C3F37, CreatorData.Modifications.Timecycle.Strength)

    Citizen.InvokeNative(0x9748FA4DE50CCE3E, "AZL_RDRO_Character_Creation_Area", true, true)
	Citizen.InvokeNative(0x9748FA4DE50CCE3E, "AZL_RDRO_Character_Creation_Area_Other_Zones_Disable", false, true)
    RequestImapCreator()

    TaskStandStill(PlayerPedId(), -1)

    local createCharCoords = CreatorData.Modifications.SpawnPlayerPosition
    exports.tpz_core.getCoreAPI().TeleportToCoords(createCharCoords.x, createCharCoords.y, createCharCoords.z, createCharCoords.h)

    -- [[ Creating camera handlers on character create (random selected coords) ]]
    local cameraCoords = CreatorData.Modifications.MainCamera
    local _cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cameraCoords.x, cameraCoords.y, cameraCoords.z, cameraCoords.rotx, cameraCoords.roty, cameraCoords.rotz, cameraCoords.fov, false, 2)

	SetCamActive(_cameraHandler, true)
	RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = cameraCoords
    CameraHandler.z      = cameraCoords.z
    CameraHandler.zoom   = cameraCoords.fov

    CurrentCharCreateCoords = createCharCoords.Coords

    SetEntityVisible(PlayerPedId(), false)

    Wait(5000)
    DoScreenFadeIn(2000)
end

function SelectCharacterModelOnCreation(isMale)
    modules = exports.tpz_core:getCoreAPI().modules() -- core modules getter.

    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(1000)
    end

	local model = isMale and "mp_male" or "mp_female"

	LoadModel(model)

    SetPlayerModel(model)
	SetModelAsNoLongerNeeded(joaat(model))
    DefaultPedSetup(PlayerPedId(), isMale)
	SetEntityVisible(PlayerPedId(), true)

	if model == 'mp_female' then 
		IdentityData.isMale = false
	end

    Wait(1000)

    Clothing = LoadClothingData()
	Groom    = LoadGroomData() -- hairs

    RemoveTagFromMetaPed(PlayerPedId(), Config.ComponentCategories.Teeth, 0)
	modules.UpdatePedVariation()

	SetEntityVisible(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)
	SetPedScale(PlayerPedId(), 1.0)

    Wait(2000)

    ApplyDefaultClothing()

	SendNUIMessage({
		action = 'set_texture_information',
		max_overlays_info = {
			body_types = #Config.BodyType.Body,
			waist      = #Config.BodyType.Waist,
			torso      = #Config.DefaultChar[SkinColorTracker].Body,
			legs       = #Config.DefaultChar[SkinColorTracker].Legs,

			heritage_types = #Config.DefaultChar,
			heritage_color_types = #Config.DefaultChar[SkinColorTracker].Heads,
		
			ageing         = #Config.overlays_info.ageing,

		},
	})

	local AppearanceCategories = {
		{ label = Locales['NUI_APPEARANCE_BODY'],          category = '.body-section'},
		{ label = Locales['NUI_APPEARANCE_HERITAGE'],      category = '.heritage-section'},
		{ label = Locales['NUI_APPEARANCE_GROOM'],         category = '.groom-section'},
		{ label = Locales['NUI_APPEARANCE_AGEING'],        category = '.ageing-section'},
		{ label = Locales['NUI_APPEARANCE_HEIGHT'],        category = '.height-section'},
		{ label = Locales['NUI_APPEARANCE_BODY_FEATURES'], category = '.bodyfeatures-section'},
		{ label = Locales['NUI_APPEARANCE_LIFESTYLE'],     category = '.lifestyle-section'},
		{ label = Locales['NUI_APPEARANCE_MAKEUP'],        category = '.makeup-section'},
	}
	for _, element in pairs (AppearanceCategories) do 

		SendNUIMessage({
			action = 'insertAppearanceCategory',
			result = element,
		})

    end

	SetCharacterDressingState() -- player models will be having no outfit by default.
	IsDressed = true -- we set it back as dressed since we undress, the state is going to be undress.

    Wait(5000)
	Heading = GetEntityHeading(PlayerPedId())

	ClearPedTasksImmediately(PlayerPedId())
	
	if isMale then
        SetFacialIdleAnimOverride(PlayerPedId(), "mood_normal_zoom", "FACE_HUMAN@GEN_MALE@BASE")
    else
        SetFacialIdleAnimOverride(PlayerPedId(), "mood_normal_zoom", "FACE_HUMAN@GEN_FEMALE@BASE")
    end

	ForcePedMotionState(PlayerPedId(), `MotionState_DoNothing`, false, 0, false)

	CreateThread(function()
		while GetCharacterData().HasNUIActive do
			Wait(0)
			FreezeEntityPosition(PlayerPedId(), false)
			DrawLightWithRange(-560.1646, -3782.066, 238.5975, 250, 250, 250, 7.0, 30.0)
		end
	end)

    DoScreenFadeIn(2000)

end

function DefaultPedSetup(ped, male)
    
	local gender                = male and "M" or "F"

	HeadIndexTracker            = male and 8 or 1
	
	PlayerSkin.eyes             = joaat(("CLOTHING_ITEM_%s_EYES_001_TINT_014"):format(gender))
	PlayerSkin.bodytype         = joaat(("CLOTHING_ITEM_%s_BODIES_UPPER_001_V_001"):format(gender))
	PlayerSkin.body             = PlayerSkin.bodytype
	PlayerSkin.headtype         = joaat(("CLOTHING_ITEM_%s_HEAD_00%d_V_001"):format(gender, HeadIndexTracker))
	PlayerSkin.legstype         = joaat(("CLOTHING_ITEM_%s_BODIES_LOWER_001_V_001"):format(gender))
	PlayerSkin.albedo           = joaat(("MP_HEAD_%sR1_SC08_C0_000_AB"):format(gender))
	PlayerSkin.teeth            = joaat(("CLOTHING_ITEM_%s_TEETH_000"):format(gender))
	PlayerSkin.waist            = Config.BodyType.Waist[1]
	PlayerSkin.torso            = joaat(Config.DefaultChar[1]['Body'][1]:format(gender))
	PlayerSkin.legs             = PlayerSkin.legstype
	PlayerSkin.beard            = { id = 0, color = 0 }
	PlayerSkin.gunbelt          = { id = 0, palette = 0 }
	--PlayerSkin.hair             = { id = 1, color = 1 }
	PlayerSkin.scale            = 1.0

	SkinColorTracker            = 1

	if not male then
		modules.IsPedReadyToRender()
		modules.EquipMetaPedOutfitPreset(ped, 7)
		modules.UpdatePedVariation()

	end

	if male then
		-- work around to fix skin on char creator
		modules.IsPedReadyToRender()
		modules.UpdateShopItemWearableState(-457866027, -425834297) -- fixes skin
		modules.ApplyShopItemToPed(-218859683)                 -- might be boots cant remember
		modules.ApplyShopItemToPed(PlayerSkin.gunbelt)
		modules.UpdateShopItemWearableState(-218859683, -2081918609) -- fixes skin
		modules.UpdatePedVariation()
	end

	PlayerSkin.sex = male and "mp_male" or "mp_female"

	-- @color : Config.color_palettes.grime[1]
	PlayerSkin.eyebrows = { id = 1, opacity = 1.0, visibility = 1, color = 1 }

	ApplyOverlay("eyebrows", 1, 1, 1, 0, 0, 1.0, 0, 1, 0x3F6E70FF, 0, 0, 1, 1.0, PlayerSkin.albedo)

	modules.IsPedReadyToRender()
	modules.EquipMetaPedOutfitPreset(ped, 3)
	modules.UpdatePedVariation()
end

-----------------------------------------------------------
--[[ Identity - Personal Information ]]--
-----------------------------------------------------------

function SetIdentityInformation(data)
	local sex = IdentityData.isMale
    IdentityData = { isMale = sex, firstname = data.firstname, lastname = data.lastname, dob = data.dob }

	SendNUIMessage({ 
		action = 'set_welcome_text', 
		text   = string.format(Locales['NUI_MAIN_PAGE_WELCOME'], data.firstname .. ' ' .. data.lastname)
	})
end

-----------------------------------------------------------
--[[ Body Types ]]--
-----------------------------------------------------------

/*
body
waist
torso:
legs
action
*/
function UpdateCharacterBodyModifications(data)
	local sex = IdentityData.isMale and 'M' or 'F'

	if data.action == 'BODY_TYPE' then 

		modules.IsPedReadyToRender()
		EquipMetaPedOutfit(PlayerPedId(), Config.BodyType.Body[data.body])
		modules.UpdatePedVariation()

		PlayerSkin.body = Config.BodyType.Body[data.body]

	elseif data.action == 'WAIST' then 

		modules.IsPedReadyToRender()
		EquipMetaPedOutfit(PlayerPedId(), Config.BodyType.Waist[data.waist])

		modules.UpdatePedVariation()

		PlayerSkin.waist = Config.BodyType.Waist[data.waist]

	elseif data.action == 'TORSO' or data.action == 'LEGS' then 

		local index    = data.action == 'TORSO' and data.torso or data.legs
		local tag      = data.action == 'TORSO' and 'Body' or 'Legs'

		local Comp     = Config.DefaultChar[SkinColorTracker]
		local compType = joaat(Comp[tag][index]:format(sex))

		if tag == "Body" then
			PlayerSkin.torso = compType

		elseif tag == 'Legs' then
			PlayerSkin.legs = compType
		end

		modules.IsPedReadyToRender()
		modules.ApplyShopItemToPed(compType)
		modules.UpdatePedVariation()
	end

end
-----------------------------------------------------------
--[[ Heritage ]]--
-----------------------------------------------------------

-- @data 
function UpdateCharacterHeritageModifications(data)
	local texture_id, color, action = data.texture_id, data.color, data.action

	local gender  = IdentityData.isMale and 'Male' or 'Female'
	local _gender = IdentityData.isMale and 'M' or 'F'

	if action == 'TYPE' then 

		SkinColorTracker    = texture_id
		local SkinColor     = Config.DefaultChar[SkinColorTracker]
		PlayerSkin.legstype = joaat(SkinColor.Legs[LegsTypeTracker]:format(_gender))
		PlayerSkin.bodytype = joaat(SkinColor.Body[BodyTypeTracker]:format(_gender))
		PlayerSkin.headtype = joaat(SkinColor.Heads[1]:format(_gender))
		PlayerSkin.albedo   = joaat(SkinColor.Albedo[1]:format(_gender))

		HeadIndexTracker   = 1
		SendNUIMessage( { action = 'setHeritageMaxColorTypes', max = #Config.DefaultChar[SkinColorTracker].Heads })

		modules.IsPedReadyToRender()
		modules.ApplyShopItemToPed(PlayerSkin.headtype)
		modules.ApplyShopItemToPed(PlayerSkin.bodytype)
		modules.ApplyShopItemToPed(PlayerSkin.legstype)

		modules.UpdatePedVariation()

	elseif action == 'COLOR' then 

		PlayerSkin.headtype = joaat(Config.DefaultChar[SkinColorTracker].Heads[color]:format(_gender))
		modules.IsPedReadyToRender()
		modules.ApplyShopItemToPed(PlayerSkin.headtype)
		modules.UpdatePedVariation()
		HeadIndexTracker = color

	end

end

-----------------------------------------------------------
--[[ Ageing ]]--
-----------------------------------------------------------

-- @data texture_id, opacity.
function UpdateCharacterAgeingTextures(data)
	local texture_id, opacity = tonumber(data.texture_id), tonumber(data.opacity)

	if Config.Debug then
		print('[UPDATE] : Character Ageing Modification Request:', "Texture ID: " .. texture_id, "Opacity: " .. opacity)
	end

	if PlayerSkin['ageing'] == nil then
		PlayerSkin['ageing'] = { id = texture_id, opacity = opacity, visibility = 0 }
	end

	PlayerSkin['ageing'].id      = texture_id
	PlayerSkin['ageing'].opacity = opacity > 0 and opacity / 10 or 0.0

	local visibility = (PlayerSkin['ageing'].id ~= 0 and PlayerSkin['ageing'].opacity > 0.0) and 1 or 0
	
	PlayerSkin['ageing'].visibility = visibility

	ApplyOverlay("ageing", visibility, PlayerSkin['ageing'].id, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, PlayerSkin['ageing'].opacity, PlayerSkin.albedo)

end

-----------------------------------------------------------
--[[ Height ]]--
-----------------------------------------------------------

function UpdateCharacterHeight()

	local options = {}

	for _, adjustment in pairs (Config.OnCharacterCreate.HeightScales) do 
		table.insert(options, adjustment.label)
	end

	local inputData = {
		title = Locales['NUI_APPEARANCE_HEIGHT_TITLE'],
		desc  = Locales['NUI_APPEARANCE_HEIGHT_DESCRIPTION'],
		buttonparam1 = Locales['ACCEPT_BUTTON'],
		buttonparam2 = Locales['DECLINE_BUTTON'],
	
		options = options,
	}
		
	TriggerEvent("tpz_inputs:getSelectedOptionsInput", inputData, function(cb)

		for _, adjustment in pairs (Config.OnCharacterCreate.HeightScales) do 

			if cb == adjustment.label then 
				SetPedScale(PlayerPedId(), adjustment.scale)
				PlayerSkin.scale = adjustment.scale
				break
			end

		end
				
	end)

end

-----------------------------------------------------------
--[[ Lifestyle ]]--
-----------------------------------------------------------

LoadSelectedCategoryLifestyleData = function(category, title)

    SELECTED_CATEGORY_TYPE = category

	local componentData = PlayerSkin[category] or { id = 0, opacity = 1.0 }

    SendNUIMessage( { action = 'selectedLifestyleCategory', 

        result = {
            max             = #Config.overlays_info[string.lower(category)],
			current         = componentData.id,
			current_opacity = componentData.opacity,

			title           = title,
			description     = Locales['NUI_LIFESTYLES_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_INFO'] or ''
        }
    })

end

-- @data texture_id, opacity.
function UpdateCharacterLifestyleTextures(data)
	local texture_id, opacity = tonumber(data.texture_id), tonumber(data.opacity)

	if Config.Debug then
		print('[UPDATE] : Character Lifestyle Modification Request:', "Category: " .. SELECTED_CATEGORY_TYPE, "Texture ID: " .. texture_id, "Opacity: " .. opacity)
	end

	if PlayerSkin[SELECTED_CATEGORY_TYPE] == nil then
		PlayerSkin[SELECTED_CATEGORY_TYPE] = { id = texture_id, opacity = opacity, visibility = 0 }
	end

	local color     = SELECTED_CATEGORY_TYPE == "grime" and 1 or 0
	local colortype = SELECTED_CATEGORY_TYPE == "grime" and 0 or 1

	PlayerSkin[SELECTED_CATEGORY_TYPE].id      = texture_id
	PlayerSkin[SELECTED_CATEGORY_TYPE].opacity = opacity > 0 and opacity / 10 or 0.0

	local visibility = (PlayerSkin[SELECTED_CATEGORY_TYPE].id ~= 0 and PlayerSkin[SELECTED_CATEGORY_TYPE].opacity > 0.0) and 1 or 0
	PlayerSkin[SELECTED_CATEGORY_TYPE].visibility = visibility
	
	ApplyOverlay(string.lower(SELECTED_CATEGORY_TYPE), visibility, PlayerSkin[SELECTED_CATEGORY_TYPE].id, 0, 0, colortype, 1.0, 0, color, 0, 0, 0, 1, PlayerSkin[SELECTED_CATEGORY_TYPE].opacity, PlayerSkin.albedo)

end


-----------------------------------------------------------
--[[ Lifestyle ]]--
-----------------------------------------------------------

GetBodyFeaturesHashByCategoryName = function(category, comp_type)

	for _, element in pairs (Config.FaceFeatures[category]) do 

		if comp_type == element.comp then
			return element.hash
		end

	end

	return nil
end


LoadSelectedCategoryBodyFeaturesData = function(category, title)

    SELECTED_CATEGORY_TYPE = category

	SendNUIMessage({ action = 'reset_bodyfeatures_components_list' })

	if category ~= 'teeth' then
	
		for index, element in pairs(Config.FaceFeatures[SELECTED_CATEGORY_TYPE]) do
	
			element.category = element.comp
			element.current  = PlayerSkin[element.comp] and PlayerSkin[element.comp].id or 0

			SendNUIMessage({
				action = 'insertBodyFeaturesCategoryElements',
				result = element,
				max    = 1.0,
				min    = -1.0,
			})
		end

	end

	SendNUIMessage( { action = 'selectedBodyFeaturesCategory', 

        result = {
			title           = title,
			description     = Locales['NUI_BODY_FEATURES_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_INFO'],
			max             = SELECTED_CATEGORY_TYPE ~= "Teeth" and #Config.FaceFeatures[SELECTED_CATEGORY_TYPE] or 0
		}
    })

end

UpdateCharacterBodyFeaturesTextures = function(data)
	local category, value = data.category, data.value

	value = tonumber(value)

	value = value == -1 and -1.0 or value
	value = value == 1 and 1.0 or value

	if PlayerSkin[category] == nil then 
		PlayerSkin[category] = { id = 0 }
	end

	PlayerSkin[category].id = value

	local hash = GetBodyFeaturesHashByCategoryName(SELECTED_CATEGORY_TYPE, category)
    modules.IsPedReadyToRender()
    SetCharExpression(PlayerPedId(), hash, value)
    modules.UpdatePedVariation()

	if Config.Debug then
		print('[UPDATE] : Character Body Feature Modification Request:', "Category: " .. SELECTED_CATEGORY_TYPE, "Component: " .. category, "Value: " .. value)
	end

end

-----------------------------------------------------------
--[[ Groom ]]--
-----------------------------------------------------------

LoadSelectedCategoryGroomData = function(category, title)
    SELECTED_CATEGORY_TYPE = category

	SendNUIMessage({ action = 'reset_groom_components_list' })

	if category == 'hair' or category == 'bow' or category == 'beard' then

		local current_component = PlayerSkin[category] and PlayerSkin[category].id or 1
		
		local current_color     = PlayerSkin[category] and PlayerSkin[category].color or 1
	
		-- texture_id
		SendNUIMessage({
			action = 'insertGroomCategoryElements',

			result = { 
				label    = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_DESC'],
				category = SELECTED_CATEGORY_TYPE,
				type     = 'texture_id',
				current  = current_component,
				max      = #Groom[category],
			},
		})

		-- primary color.
		SendNUIMessage({
			action = 'insertGroomCategoryElements',

			result = { 
				label    = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_COLORS'], 
				category = SELECTED_CATEGORY_TYPE,
				type     = 'color',
				current  = current_color,
				max      = Groom[category][current_component] ~= nil and #Groom[category][current_component] or 1,
			},

		})

		SendNUIMessage( { action = 'selectedGroomCategory', 
		
            result = {
				title              = title,
				description        = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_INFO'],
				max                = max_elements,
	
				current_texture_id = current_component,
				max_texture_id     = #Groom[category],
	
				current_color      = current_color,
				max_colors         = Groom[category][current_component] ~= nil and #Groom[category][current_component] or 1,
			}
		})

	else 

		category                = category == 'overlay' and 'hair' or category
		local _category         = category == 'hair' and 'hair_overlay' or category
		local current_component = PlayerSkin[_category] and PlayerSkin[_category].id or 1
		local current_color     = PlayerSkin[_category] and PlayerSkin[_category].color or 1
		local current_opacity   = PlayerSkin[_category] and PlayerSkin[_category].opacity or 10

		local max_texture_id    = #Config.overlays_info[category]
		local max_colors        = #Config.color_palettes[category]

		-- texture_id
		SendNUIMessage({
			action = 'insertGroomCategoryElements',

			result = { 
				label    = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_DESC'],
				category = SELECTED_CATEGORY_TYPE,
				type     = 'texture_id',
				current  = current_component,
				max      = max_texture_id,
			},
		})

		-- primary color.
		SendNUIMessage({
			action = 'insertGroomCategoryElements',

			result = { 
				label    = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_COLORS'], 
				category = SELECTED_CATEGORY_TYPE,
				type     = 'color',
				current  = current_color,
				max      = max_colors
			},

		})


		-- opacity
		SendNUIMessage({
			action = 'insertGroomCategoryElements',

			result = { 
				label    = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_OPACITY'],
				category = SELECTED_CATEGORY_TYPE,
				type     = 'opacity',
				current  = current_opacity,
				max      = 10,
			},
		})

		SendNUIMessage( { action = 'selectedGroomCategory', 
		
		    result = {
				title              = title,
				description        = Locales['NUI_GROOM_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_INFO'],
				max                = 3,
	
				current_texture_id = current_component,
				max_texture_id     = max_texture_id,
	
				current_color      = current_color,
				max_colors         = max_colors,
	
				current_opacity    = current_opacity,
			}
		})
	
	end
	
end

UpdateCharacterGroomTextures = function(data)
	local actionType, texture_id, color = data.type, data.texture_id, data.color

	if SELECTED_CATEGORY_TYPE == 'hair' or SELECTED_CATEGORY_TYPE == 'bow' or SELECTED_CATEGORY_TYPE == 'beard' then

		if Config.Debug then
			print('[UPDATE] : Character Groom Modification Request:', "Category: " .. SELECTED_CATEGORY_TYPE, "Type: " .. actionType, "Texture ID: " .. texture_id, "Color: " .. color)
		end
	
		if PlayerSkin[SELECTED_CATEGORY_TYPE] == nil then
			PlayerSkin[SELECTED_CATEGORY_TYPE] = {}
		end
	
		local visibility = texture_id == 0 and 0 or 1

		PlayerSkin[SELECTED_CATEGORY_TYPE] = { 
			id         = texture_id, 
			color      = color, 
		}
	
		modules.IsPedReadyToRender()

		if texture_id > 0 then 

			local hash = Groom[SELECTED_CATEGORY_TYPE][texture_id][color].hex

			modules.ApplyShopItemToPed(hash)
		else
			local capitalizedCategoryName = exports.tpz_core:getCoreAPI().Capitalize(SELECTED_CATEGORY_TYPE)
			RemoveTagFromMetaPed(PlayerPedId(), Config.ComponentCategories[capitalizedCategoryName])
		end

		if actionType == 'texture_id' then 

			SendNUIMessage({
				action = 'updateGroomSpecificData',
				max_colors = Groom[SELECTED_CATEGORY_TYPE][texture_id] ~= nil and #Groom[SELECTED_CATEGORY_TYPE][texture_id] or 1,
				category   = SELECTED_CATEGORY_TYPE,
			})

		end

		modules.UpdatePedVariation()
	else 

		local opacity   = tonumber(data.opacity)
		local _category = SELECTED_CATEGORY_TYPE == 'overlay' and 'hair_overlay' or SELECTED_CATEGORY_TYPE
		category = SELECTED_CATEGORY_TYPE == 'overlay' and 'hair' or SELECTED_CATEGORY_TYPE

		if Config.Debug then
			print('[UPDATE] : Character Groom Modification Request:', "Category: " .. _category, "Type: " .. actionType, "Texture ID: " .. texture_id, "Color: " .. color, "Opacity: " .. opacity)
		end

		if PlayerSkin[_category] == nil then
			PlayerSkin[_category] = {}
		end
	
		PlayerSkin[_category] = { 
			id         = texture_id, 
			color      = color, 
			visibility = 1, 
			opacity    = opacity > 0 and opacity / 10 or 0.0
		}

		local visibility = (PlayerSkin[_category].id ~= 0 and PlayerSkin[_category].opacity > 0.0) and 1 or 0
		PlayerSkin[_category].visibility = visibility

		ApplyOverlay(category, visibility, PlayerSkin[_category].id, 1, 0, 0, 1.0, 0, 1, PlayerSkin[_category].color, 0, 0, 1, PlayerSkin[_category].opacity, PlayerSkin.albedo)
	
		if actionType == 'texture_id' then 

			SendNUIMessage({
				action = 'updateGroomSpecificData',
				max_colors = #Config.color_palettes[category],
				category   = SELECTED_CATEGORY_TYPE,
			})

		end
	end
	

end


-----------------------------------------------------------
--[[ Makeup ]]--
-----------------------------------------------------------

local overlayLookup = {
    ['lipsticks']  = 7,
    ['eyeliners']  = 15,
    ['shadows']    = 5,
    ['foundation'] = 5,
}

LoadSelectedCategoryMakeupData = function(category, title)
    SELECTED_CATEGORY_TYPE  = category
	
	local current_component = PlayerSkin[category] and PlayerSkin[category].id or 0
	local current_color     = PlayerSkin[category] and PlayerSkin[category].primary_color or 0
	local current_color2    = PlayerSkin[category] and PlayerSkin[category].secondary_color or 0
	local current_variant   = PlayerSkin[category] and PlayerSkin[category].variant or 1
	local current_opacity   = PlayerSkin[category] and PlayerSkin[category].opacity or 9
		
	SendNUIMessage({ action = 'reset_makeup_components_list' })

	local max_elements = 3

	SendNUIMessage({
		action = 'insertMakeupCategoryElements',

		result = { 
			label    = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_TEXTURE'],
			category = SELECTED_CATEGORY_TYPE,
			type     = 'texture_id',
			current  = current_component,
			max      = #Config.overlays_info[category],
		},
	})
	
	SendNUIMessage({
		action = 'insertMakeupCategoryElements',

		result = { 
			label    = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_PRIMARY_COLOR'],
			category = SELECTED_CATEGORY_TYPE,
			type     = 'color',
			current  = current_color,
			max      = 10,
		},
	})

	if category == 'lipsticks' then 
		
		SendNUIMessage({
			action = 'insertMakeupCategoryElements',
	
			result = { 
				label    = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_SECONDARY_COLOR'],
				category = SELECTED_CATEGORY_TYPE,
				type     = 'color2',
				current  = current_color2,
				max      = 10,
			},
		})

		max_elements = max_elements +1

	end

	if category == "lipsticks" or category == "shadows" or category == "eyeliners" or category == "foundation" then

		SendNUIMessage({
			action = 'insertMakeupCategoryElements',
	
			result = { 
				label    = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_VARIANT'],
				category = SELECTED_CATEGORY_TYPE,
				type     = 'variant',
				current  = current_variant,
				max      = overlayLookup[category],
			},
		})

		max_elements = max_elements +1
	end

	-- opacity
	SendNUIMessage({
		action = 'insertMakeupCategoryElements',

		result = { 
			label    = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_OPACITY'],
			category = SELECTED_CATEGORY_TYPE,
			type     = 'opacity',
			current  = current_opacity,
			max      = 9,
		},
	})

	SendNUIMessage( { action = 'selectedMakeupCategory', 
	
	    result = {
			title              = title,
			description        = Locales['NUI_MAKEUP_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_DESC'],
			max                = max_elements,
	
			current_texture_id = current_component,
			max_texture_id     = #Config.overlays_info[category],
	
			primary_color      = current_color,
			secondary_color    = current_color2,

			current_variant    = current_variant,
			max_variants       = overlayLookup[category] or 0,

			current_opacity    = current_opacity,
		}
	})

end

UpdateCharacterMakeupTextures = function(data)
	local actionType, texture_id, color, color2, variant, opacity = data.type, data.texture_id, data.color, data.color2, data.variant, data.opacity

	if Config.Debug then
		print('[UPDATE] : Character Makeup Modification Request:', "Category: " .. SELECTED_CATEGORY_TYPE, "Type: " .. actionType, "Texture ID: " .. texture_id, "Primary Color: " .. color, "Secondary Color: " .. color2, "Variant: " .. variant, "Opacity: " .. opacity)
	end

	if PlayerSkin[SELECTED_CATEGORY_TYPE] == nil then
		PlayerSkin[SELECTED_CATEGORY_TYPE] = {}
	end

	PlayerSkin[SELECTED_CATEGORY_TYPE] = { 
		id              = texture_id, 
		primary_color   = color, 
		secondary_color = color2, 
		tertiary_color  = 0,
		visibility      = 1, 
		variant         = variant,
		opacity         = opacity > 0 and opacity / 10 or 0.0
	}

	local visibility = PlayerSkin[SELECTED_CATEGORY_TYPE].id ~= 0 and 1 or 0
	PlayerSkin[SELECTED_CATEGORY_TYPE].visibility = visibility

	local overlay_data = PlayerSkin[SELECTED_CATEGORY_TYPE]

	ApplyOverlay(SELECTED_CATEGORY_TYPE, visibility,
	overlay_data.id, 1, 0, 0,
	1.0, 0, 1, overlay_data.primary_color, overlay_data.secondary_color or 0,
	overlay_data.tertiary_color or 0, overlay_data.variant or 1,
	overlay_data.opacity, PlayerSkin.albedo)
end

-----------------------------------------------------------
--[[ Clothing ]]--
-----------------------------------------------------------

local GetLabelNameFromClothingCategory = function(category)

	for _, cloth in pairs (Config.ClothingCategories) do 

		if category == cloth.category then
			return cloth.label

		end

	end

	return 'N/A'

end

LoadSelectedCategoryClothingData = function(category, title)

    SELECTED_CATEGORY_TYPE = string.lower(category)

	local componentData = PlayerSkin[category] or { id = 0, palette = 1, tint0 = 0, tint1 = 0, tint2 = 0 }
	local title = GetLabelNameFromClothingCategory(category)

    SendNUIMessage( { action = 'selectedCategory', 

        result = {
            max          = #Clothing[SELECTED_CATEGORY_TYPE],
			current      = componentData.id,
			title        = title,
			description  = Locales['NUI_CATEGORY_CLOTHING_' .. string.upper(SELECTED_CATEGORY_TYPE) .. '_TITLE'] or ''
        }
    })

	componentData.actionType = 'COMPONENT'
    LoadSelectedOutfitById(componentData, true)

end

LoadSelectedOutfitById = function(data, firstLoad)
    local texture_id, palette, tint0, tint1, tint2, actionType = data.id, data.palette or 1, data.tint0, data.tint1, data.tint2, data.actionType
    local player = PlayerPedId()

	if PlayerSkin[SELECTED_CATEGORY_TYPE] == nil then
		PlayerSkin[SELECTED_CATEGORY_TYPE] = {}
	end

	PlayerSkin[SELECTED_CATEGORY_TYPE] = { id = texture_id, palette = palette, tint0 = tint0, tint1 = tint1, tint2 = tint2, drawable = 0, albedo = 0, normal = 0, material = 0}

	SendNUIMessage( { 
        action = 'setOutfitComponentInformation', 
        current = palette, 
		tint0   = PlayerSkin[SELECTED_CATEGORY_TYPE].tint0,
		tint1   = PlayerSkin[SELECTED_CATEGORY_TYPE].tint1,
		tint2   = PlayerSkin[SELECTED_CATEGORY_TYPE].tint2,
        max = (Clothing[SELECTED_CATEGORY_TYPE][texture_id] and #Clothing[SELECTED_CATEGORY_TYPE][texture_id] or 1),
    })

    if actionType == 'COMPONENT' or actionType == 'PALETTE' then

        if texture_id ~= 0 then

            local outfitHash = Clothing[SELECTED_CATEGORY_TYPE][texture_id][palette].hex

            modules.IsPedReadyToRender()
            modules.ApplyShopItemToPed(outfitHash)

        else
			PlayerSkin[SELECTED_CATEGORY_TYPE] = { id = 0, palette = 1, tint0 = 0, tint1 = 0, tint2 = 0, drawable = 0, albedo = 0, normal = 0, material = 0}
            RemoveTagFromMetaPed(PlayerPedId(), Config.ComponentCategories[SELECTED_CATEGORY_TYPE])
        end

    elseif actionType == 'TINT' and texture_id ~= 0 then
        modules.IsPedReadyToRender()

		local TagData = GetMetaPedData(SELECTED_CATEGORY_TYPE == "Boots" and "boots" or SELECTED_CATEGORY_TYPE)

		if TagData then
			local palette = Config.clothesPalettes[palette]
			
			PlayerSkin[SELECTED_CATEGORY_TYPE].drawable = TagData.drawable
			PlayerSkin[SELECTED_CATEGORY_TYPE].albedo   = TagData.albedo
			PlayerSkin[SELECTED_CATEGORY_TYPE].normal   = TagData.normal
			PlayerSkin[SELECTED_CATEGORY_TYPE].material = TagData.material

			SetMetaPedTag(PlayerPedId(), TagData.drawable, TagData.albedo, TagData.normal, TagData.material, palette, tint0, tint1, tint2)
		end
    end

    modules.UpdatePedVariation()

	if SELECTED_CATEGORY_TYPE == 'coatclosed' and texture_id == 0 and not firstLoad then
		SetCharacterDressingState()
		SetCharacterDressingState()
	else
		
		FixClothingProperlyOnCategorySelect(SELECTED_CATEGORY_TYPE)
	end
end

-----------------------------------------------------------
--[[ General ]]--
-----------------------------------------------------------

function SetCharacterDressingState()
	IsDressed = not IsDressed

	local UndressCategories = {
		-- Core clothing
		Hat          = `HATS`,
		Shirt        = `SHIRTS_FULL`,
		ShirtOver    = `SHIRTS_FULL_OVERPANTS`,
		Vest         = `VESTS`,
		Vests        = `VESTS`,
		Coat         = `COATS`,
		CoatHeavy    = `COATS_HEAVY`,
		CoatClosed   = `COATS_CLOSED`,
		Cloak        = `CLOAKS`,
		Poncho       = `PONCHOS`,
		Dress        = `DRESSES`,
		Skirt        = `SKIRTS`,
		Pant         = `PANTS`,
		Stockings    = `STOCKINGS`,
		Chap         = `CHAPS`,
		Suspender    = `SUSPENDERS`,
	
		-- Footwear
		Boots        = `BOOTS`,
		Spurs        = `BOOT_ACCESSORIES`,
		Spats        = `SPATS`,
	
		-- Belts / Holsters / Ammo
		Belt         = `BELTS`,
		Buckle       = `BELT_BUCKLES`,
		Gunbelt      = `GUNBELTS`,
		GunbeltAccs  = `GUNBELT_ACCS`,
		Holster      = `HOLSTERS_LEFT`,
		Loadouts     = `LOADOUTS`,
		AmmoPistol   = `AMMO_PISTOLS`,
		AmmoRifle    = `AMMO_RIFLES`,
	
		-- Accessories
		Satchels     = `SATCHELS`,
		Gloves       = `GLOVES`,
		Gauntlets    = `GAUNTLETS`,
		Eyewear      = `EYEWEAR`,
		Necktie      = `NECKTIES`,
		Neckwear     = `NECKWEAR`,
		Bracelet     = `JEWELRY_BRACELETS`,
		Badge        = `BADGES`,
		Armor        = `ARMOR`,
		Apron        = `APRONS`,
		Accessories  = `ACCESSORIES`,
	
		-- Masks / Talismans
		Mask         = `MASKS`,
		MaskLarge    = `MASKS_LARGE`,
		TalismanHol  = `TALISMAN_HOLSTER`,
		TalismanBelt = `TALISMAN_BELT`,
	}
	
	if not IsDressed then 

		local gender     = IdentityData.isMale and 'Male' or 'Female'
		local _gender    = IdentityData.isMale and 'M' or 'F'
		local SkinColor  = Config.DefaultChar[SkinColorTracker]
		local albedo     = Config.texture_types[gender].albedo
		local material   = Config.texture_types[gender].material

		modules.IsPedReadyToRender()
		modules.ApplyShopItemToPed(joaat(SkinColor.Heads[HeadIndexTracker]:format(_gender)))
		modules.ApplyShopItemToPed(joaat(SkinColor.Body[BodyTypeTracker]:format(_gender)))
		modules.ApplyShopItemToPed(joaat(SkinColor.Legs[LegsTypeTracker]:format(_gender)))
		Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, joaat(SkinColor.Albedo[1]:format(_gender)), material)
		modules.UpdatePedVariation()

		modules.IsPedReadyToRender()

		for _, category in pairs(UndressCategories) do
			if modules.IsMetaPedUsingComponent(category) then -- IsMetaPedUsingComponentCategory
				RemoveTagFromMetaPed(PlayerPedId(), category, 0)

				-- We set the player skin outfits only once.
				if PlayerSkin[_] == nil then
					PlayerSkin[_] = { id = 0, palette = 1, tint0 = 0, tint1 = 0, tint2 = 0, drawable = 0, albedo = 0, normal = 0, material = 0}
				end

			end
		end

		modules.UpdatePedVariation()
	
	else 

		modules.IsPedReadyToRender()

		for category, data in pairs(PlayerSkin) do

			-- Drawable check is required for preventing loading non-clothes.
			if type(PlayerSkin[category]) == "table" and data.drawable ~= nil then 

				if data.id ~= 0 then

					local outfitHash = Clothing[category][data.id][data.palette].hex
					modules.ApplyShopItemToPed(outfitHash)

					if data.drawable ~= 0 then
						local palette = Config.clothesPalettes[data.palette]
						SetMetaPedTag(PlayerPedId(), data.drawable, data.albedo, data.normal, data.material, palette, data.tint0, data.tint1, data.tint2)
					end

					modules.UpdatePedVariation()

					Wait(150)
					FixClothingProperlyOnCategorySelect(category)
				end
			end
		end

	end

end