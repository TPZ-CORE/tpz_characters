
-----------------------------------------------------------
--[[ Prompts  ]]--
-----------------------------------------------------------

Prompts       = GetRandomIntInRange(0, 0xffffff)
PromptsList   = {}

CreateCharacterPrompts = function()

    for index, tprompt in pairs (Config.OnCharacterCreate.CameraAdjustmentPrompts) do

        local str = tprompt.label
        local keyPress = tprompt.key1
        local keyPress2 = tprompt.key2

        local dPrompt = PromptRegisterBegin()
        PromptSetControlAction(dPrompt, keyPress)

        if keyPress2 then
            PromptSetControlAction(dPrompt, keyPress2)
        end
        
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(dPrompt, str)
        PromptSetEnabled(dPrompt, 1)
        PromptSetVisible(dPrompt, 1)
        PromptSetStandardMode(dPrompt, 0)
        PromptSetHoldMode(dPrompt, false)
        PromptSetGroup(dPrompt, Prompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C, dPrompt, true)
        PromptRegisterEnd(dPrompt)
    
        table.insert(PromptsList, {prompt = dPrompt, type = index})
    end

end


local SelectorPrompts = GetRandomIntInRange(0, 0xffffff)
local SelectorPromptsList = {}

local SelectorPromptTypesList = {

    [1] = {
        Type = "PREVIOUS_CHARACTER"
    },

    [2] = {

        Type = "NEXT_CHARACTER"
    },

    [3] = {

        Type = "SELECT_CHARACTER"
    },

    [4] = {
        Type = 'CREATE_CHARACTER',
    },

    [5] = {
        Type = 'DELETE_CHARACTER',
    },
}

RegisterCharacterSelectorPrompts = function()

    for index, tprompt in pairs (SelectorPromptTypesList) do

        local str = Config.OnCharacterSelector.Prompts[tprompt.Type].label
        local keyPress =  Config.OnCharacterSelector.Prompts[tprompt.Type].key
    
        local dPrompt = PromptRegisterBegin()
        PromptSetControlAction(dPrompt, keyPress)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(dPrompt, str)
        PromptSetEnabled(dPrompt, 1)
        PromptSetVisible(dPrompt, 1)
        PromptSetStandardMode(dPrompt, 1)
        PromptSetHoldMode(dPrompt, Config.OnCharacterSelector.Prompts[tprompt.Type].hold)
        PromptSetGroup(dPrompt, SelectorPrompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C, dPrompt, true)
        PromptRegisterEnd(dPrompt)
    
        table.insert(SelectorPromptsList, {prompt = dPrompt, type = tprompt.Type})
    end

end

GetSelectorPromptData = function ()
    return SelectorPrompts, SelectorPromptsList
end

ClearSelectorPrompt = function ()
    Citizen.InvokeNative(0x00EDE88D4D13CF59, SelectorPrompts) -- UiPromptDelete
end

--[[-------------------------------------------------------
 Events
]]---------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    Citizen.InvokeNative(0x00EDE88D4D13CF59, Prompts) -- UiPromptDelete
  --  Citizen.InvokeNative(0x00EDE88D4D13CF59, SelectorPrompts) -- UiPromptDelete
end)


-----------------------------------------------------------
--[[ General Functions  ]]--
-----------------------------------------------------------

function SetPlayerModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function PerformRequest(hash)
    RequestModel(hash, 0)
    local bacon = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0)
        bacon = bacon + 1
        Citizen.Wait(0)
        if bacon >= 100 then break end
    end
end

LoadModel = function(inputModel)
   local model = joaat(inputModel)

   RequestModel(model)

   while not HasModelLoaded(model) do RequestModel(model)
       Citizen.Wait(10)
   end
end


LoadHashModel = function(model)
    RequestModel(model)

    while not HasModelLoaded(model) do RequestModel(model)
        Citizen.Wait(10)
    end
end


RemoveEntityProperly = function(entity, objectHash)
	DeleteEntity(entity)
	DeletePed(entity)
	SetEntityAsNoLongerNeeded( entity )

	if objectHash then
		SetModelAsNoLongerNeeded(objectHash)
	end
end 

function RemoveImaps()
    if IsImapActive(183712523) then
        RequestImap(183712523)
    end

    if IsImapActive(-1699673416) then
        RemoveImap(-1699673416)
    end

    if IsImapActive(1679934574) then
        RemoveImap(1679934574)
    end
end

function RequestImapCreator()
    if not IsImapActive(183712523) then
        RequestImap(183712523)
    end
    if not IsImapActive(-1699673416) then
        RequestImap(-1699673416)
    end
    if not IsImapActive(1679934574) then
        RequestImap(1679934574)
    end
end

function StartCam(x, y, z, rotx, roty, rotz, fov)
	Citizen.InvokeNative(0x17E0198B3882C2CB, PlayerPedId()) -- start solo tutorial session
	DestroyAllCams(true)

    local cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, rotx, roty, rotz, fov, false, 2)
    
	SetCamActive(cameraHandler, true)

	RenderScriptCams(true, true, 500, true, true)

end

function IsPedReadyToRender(ped)
    Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped) do
        Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
        Wait(0)
    end
end

function ApplyComponentToPed(ped, comp)

    ApplyShopItemToPed(ped, comp)

    Citizen.InvokeNative(0x66b957aac2eaaeab, ped, comp, 0, 0, 1, 1) -- _UPDATE_SHOP_ITEM_WEARABLE_STATE
    
    Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
    UpdateVariation(ped)
end


function UpdateVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped or PlayerPedId(), false, true, true, true, false)
    Citizen.InvokeNative(0xAAB86462966168CE, ped or PlayerPedId(), true)
end


function toggleOverlayChange(ped, name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk,
                             palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var,
                             opacity, albedo)

    if name == nil or tx_id == nil then return end
    
    for k, v in pairs(MP.OverlayAllLayers) do
        if v.name == name then
            v.visibility = visibility
            if visibility ~= 0 then
                v.tx_normal = tx_normal
                v.tx_material = tx_material
                v.tx_color_type = tx_color_type
                v.tx_opacity = tx_opacity
                v.tx_unk = tx_unk
                if tx_color_type == 0 then
                    v.palette = MP.ColorPalettes[name][palette_id]
                    v.palette_color_primary = palette_color_primary
                    v.palette_color_secondary = palette_color_secondary
                    v.palette_color_tertiary = palette_color_tertiary
                end
                if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
                    v.var = var
                    if tx_id ~= 0 then
                        v.tx_id = MP.Overlays[name][1].id
                    end
                else
                    v.var = 0
                    if tx_id ~= 0 and MP.Overlays[name][tx_id] then
                        v.tx_id = MP.Overlays[name][tx_id].id
                    end
                end
                v.opacity = opacity
            end
        end
    end

    local sex = getGender()

    local current_texture_settings = MP.TextureTypes[sex]

    if textureId ~= -1 then
        Citizen.InvokeNative(0xB63B9178D0F58D82, textureId) -- reset texture
        Citizen.InvokeNative(0x6BEFAA907B076859, textureId) -- remove texture
    end

    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, current_texture_settings.normal,current_texture_settings.material) -- create texture

    for k, v in pairs(MP.OverlayAllLayers) do
        if v.visibility ~= 0 then
            local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02, textureId, v.tx_id, v.tx_normal,
                v.tx_material, v.tx_color_type, v.tx_opacity, v.tx_unk)                    -- create overlay
            if v.tx_color_type == 0 then
                Citizen.InvokeNative(0x1ED8588524AC9BE1, textureId, overlay_id, v.palette) -- apply palette
                Citizen.InvokeNative(0x2DF59FFE6FFD6044, textureId, overlay_id, v.palette_color_primary,
                    v.palette_color_secondary, v.palette_color_tertiary)                   -- apply palette colours
            end

            Citizen.InvokeNative(0x3329AAE2882FC8E4, textureId, overlay_id, v.var);     -- apply overlay variant
            Citizen.InvokeNative(0x6C76BC24F8BB709A, textureId, overlay_id, v.opacity); -- apply overlay opacity
        end
    end

    while not Citizen.InvokeNative(0x31DC8D3F216D8509, textureId) do -- wait till texture fully loaded
        Citizen.Wait(0)
    end

    Citizen.InvokeNative(0x92DAABA2C1C10B0E, textureId)                           -- update texture
    Citizen.InvokeNative(0x0B46E25761519058, ped, GetHashKey("heads"), textureId)      -- apply texture to current component in category "heads"
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) -- refresh ped components
end

function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

function ApplyShopItemToPed(ped, comp)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped or PlayerPedId(), comp, false, false, false)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped or PlayerPedId(), comp, false, true, false)
end

function GetGenderByInteger(int)

    local sex = "male"

    if int == 1 then
        sex = "female"
    end

    return sex

end

function getGender() 

    local sex = "male"

    if SkinData['sex'] == 1 then
        sex = "female"
    end

    return sex

end

function LoadEntitySkinComps(ped, skinComp, gender)

    local localSkinData = {}

    local decodedSkinComp = json.decode(skinComp)

    -- decoding all skin comp from database and inserting into new list.
    for index, value in pairs (decodedSkinComp) do
        localSkinData[index] = value
    end

    local sex    = "male"
	local albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")

    if tonumber(gender) == 1 then
        sex    = "female"
        albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")

		Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 7, true)
		EquipMetaPedOutfitPreset(ped, 7)
    else
		Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 0, 0)
    end

	Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
	Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 3, 0) -- outfits

    UpdateVariation(ped)
	IsPedReadyToRender(ped)

    -- Load customization data
    LoadSelectedListResults(sex)

    -- adding default customization first before updating skinComp data.
    for customization, hash in pairs (MP.DefaultCustomization[sex]) do
        ApplyComponentToPed(ped, hash)
    end

    local facialAndClothingList =  getCharacterCustomizationTypes(tonumber(gender))

    -- Load General Facials & Clothing
    for facial_index, facial in pairs (facialAndClothingList) do

        if localSkinData[facial.tag] and tonumber(localSkinData[facial.tag]) ~= -1 then

            if facial.tag == "waist" or facial.tag == "bodies_full" then
                            
                local hash = localSkinData[facial.tag]

                Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, hash)
            else 

                print(facial.tag)

                local hash = localSkinData[facial.tag]

                if facial.tag ~= "boots" then
                    UpdateShopItemWearableState(ped, `base`)
                    ApplyShopItemToPed(ped, hash)
                else
                    UpdateShopItemWearableState(ped, hash, -2081918609, 0, true, 1) -- tucking pants into boots
                    ApplyShopItemToPed(ped, hash)
                end

                Citizen.InvokeNative(0x704C908E9C405136, ped)
            end

        end

        if tonumber(localSkinData[facial.tag]) == 0 or tonumber(localSkinData[facial.tag]) == -1 then
            Citizen.InvokeNative(0xD710A5007C2AC539, ped, MP.DefaultHashList[facial.tag], 0)

            if facial.tag == 'gunbelts' then
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0x3F1F01E5, 0) 
                Citizen.InvokeNative(0xD710A5007C2AC539, ped, 0xDA0E2C55, 0) 
            end

            --UpdateVariation(ped)
        end
        
    end

    -- Load Overlays

    for tag, overlayData in pairs(MP.Overlays) do
        if MP.CustomizationOverlayElements[tag] then

            local overlayKeyData = MP.CustomizationOverlayElements[tag]

            if localSkinData[tag] and tonumber(localSkinData[tag]) ~= -1 and tag ~= "eyebrows" then
                toggleOverlayChange(ped, tag, localSkinData[overlayKeyData.vis], localSkinData[overlayKeyData.txt_id], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, localSkinData[overlayKeyData.opacity], albedo )
            end

            if tag == "eyebrows" then
                toggleOverlayChange(ped, tag, localSkinData[overlayKeyData.vis], localSkinData[overlayKeyData.txt_id], 1, 0, 0, 1.0, 0, 1, localSkinData[overlayKeyData.color], 0, 0, 1, localSkinData[overlayKeyData.opacity], albedo )
            end

        end

        -- Load makeup
        if MP.MakeupOverlayTypes[tag] then
            
            local overlay = MP.MakeupOverlayTypes[tag]

            toggleOverlayChange(ped, tag, localSkinData[overlay.visibility],
            localSkinData[overlay.txt_id], 1, 0, 0,

            1.0, 0, 1, localSkinData[overlay.color] or 0, localSkinData[overlay.color2] or 0,

            localSkinData[overlay.color3] or 0, localSkinData[overlay.variant] or 1,
            localSkinData[overlay.opacity], albedo)

        end

    end

    -- Load Ageing
    if localSkinData['ageing_tx_id'] and tonumber(localSkinData['ageing_tx_id']) ~= -1 then
        toggleOverlayChange(ped, "ageing", localSkinData['ageing_visibility'], localSkinData['ageing_tx_id'], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, localSkinData['ageing_opacity'], albedo)
    end

    UpdateVariation(ped)

end

-- facials, clothing
function getCharacterCustomizationTypes(sex)

    local elements = {}

    for _, element in pairs (MP.CustomizationElements) do

        if not element.sex then

            table.insert(elements, element)

        elseif element.sex and element.sex == sex then

            table.insert(elements, element)
        end

    end

    return elements

end
