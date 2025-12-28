local hat, vest, boots, pants, shirt, gunbelt, maskcoat, closedcoat, cloak, poncho, eyewear = true, true, true, true, true, true, true, true, true, true, true
local undress = false

local ClothingList = nil

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local IsClothingPartAvailableByName = function(clothingType)
    local clientData = exports.tpz_core:getCoreAPI().GetPlayerClientData()

    clientData.skinComp = json.decode(clientData.skinComp)

    if clientData.skinComp == nil or clientData.skinComp[clothingType] == nil then 
        print(string.format('[1]. No %s available to take out or equip.', clothingType))
        return false
    end

    if clientData.skinComp[clothingType].id == 0 then
        print(string.format('[2]. No %s available to take out or equip.', clothingType))
        return false
    end

    return true

end

local PerformDressingStateActionByName = function(clothingType, clothingHashType, equip)
    local modules = exports.tpz_core:getCoreAPI().modules() -- core modules getter.

    if ClothingList == nil then 
        ClothingList = LoadClothingData()
    end
    
    local clientData = exports.tpz_core:getCoreAPI().GetPlayerClientData()

    clientData.skinComp = json.decode(clientData.skinComp)

    if clientData.skinComp == nil or clientData.skinComp[clothingType] == nil then 
        return 
    end

    if clientData.skinComp[clothingType].id == 0 then
        return 
    end

    if not equip then 

        modules.IsPedReadyToRender()    
        RemoveTagFromMetaPed(PlayerPedId(), joaat(clothingHashType))
        modules.UpdatePedVariation()

    else

        local ped  = PlayerPedId()
        local data = clientData.skinComp[clothingType]
        
        if data.id ~= 0 then

            for _, cloth in pairs (Config.ClothingCategories) do

                if cloth.category == clothingType then
                    local outfitHash = ClothingList[cloth.category][data.id][data.palette].hex

                    modules.IsPedReadyToRender(ped)
                    modules.ApplyShopItemToPed(outfitHash, ped)
        
                    if data.drawable ~= 0 then
                        local palette = Config.clothesPalettes[data.palette]
                        
                        SetMetaPedTag(ped, data.drawable, data.albedo, data.normal, data.material, palette, data.tint0, data.tint1, data.tint2)
                    end
        
                    modules.UpdatePedVariation(ped)
                    
                    FixClothingProperlyOnCategorySelect(cloth.category, skinComp, ped)
    
                    break
                end
    
            end

        end

    end

end

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tpz_core:isPlayerRespawned")
AddEventHandler("tpz_core:isPlayerRespawned", function()
    hat, vest, boots, pants, shirt, gunbelt, maskcoat, closedcoat, cloak, poncho, eyewear = true, true, true, true, true, true, true, true, true, true, true
    undress = false
    
end)

-----------------------------------------------------------
--[[ Commands  ]]--
-----------------------------------------------------------

-- Reload Character Command (if set to true).
if Config.ReloadCharacter.Enabled then

    local reloadSkinCooldown = 0

    TriggerEvent("chat:addSuggestion", "/" .. Config.ReloadCharacter.Command, Config.ReloadCharacter.Description)

    RegisterCommand(Config.ReloadCharacter.Command, function()

        local PlayerData = GetCharacterData()

        if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
            exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
            return
        end

        if reloadSkinCooldown <= 0 then

            local playerPed = PlayerPedId()
            local hogtied   = Citizen.InvokeNative(0x3AA24CCC0D451379, playerPed)
            local cuffed    = Citizen.InvokeNative(0x74E559B3BC910685, playerPed)

            if hogtied or cuffed or IsPedOnMount(playerPed) or IsPedInAnyVehicle(playerPed, false) then
                exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_RELOAD_NOT_PERMITTED"], 3000)
                return
            end

            --local currentHealth = GetEntityHealth(playerPed)

            local data = exports.tpz_core:getCoreAPI().GetPlayerClientData()

            reloadSkinCooldown = Config.ReloadCharacter.Cooldown

            local gender = data.gender == 0 and "mp_male" or "mp_female"
            LoadEntityComponents(PlayerPedId(), gender, data.skinComp, true, true)

            --SetEntityHealth(PlayerPedId(), currentHealth)

            exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_RELOADED"], 3000)

            Citizen.CreateThread(function()
                while reloadSkinCooldown > 0 do
                    Wait(1000)
                    reloadSkinCooldown = reloadSkinCooldown - 1
                end
            end)

        else
            exports.tpz_core:getCoreAPI().NotifyObjective(string.format(Locales['RELOAD_CHARACTER_COMMAND_COOLDOWN'], reloadSkinCooldown), 3000)
        end

    end)

end


RegisterCommand('dress', function()

    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    undress = false
    hat, vest, boots, pants, shirt, gunbelt, maskcoat, closedcoat, cloak, poncho, eyewear = true, true, true, true, true, true, true, true, true, true, true
    
    local data = exports.tpz_core:getCoreAPI().GetPlayerClientData()
    local gender = data.gender == 0 and "mp_male" or "mp_female"

    LoadEntityComponents(PlayerPedId(), gender, data.skinComp, false, false, true)
end)

RegisterCommand('undress', function()
    local modules = exports.tpz_core:getCoreAPI().modules() -- core modules getter.

    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    undress = true

    hat, vest, boots, pants, shirt, gunbelt, maskcoat, closedcoat, cloak, poncho, eyewear = false, false, false, false, false, false, false, false, false, false, false

    local data = exports.tpz_core:getCoreAPI().GetPlayerClientData()

    local UndressCategories = {
		-- Core clothing
		hat          = `HATS`,
		shirt        = `SHIRTS_FULL`,
		shirtover    = `SHIRTS_FULL_OVERPANTS`,
		cest         = `VESTS`,
		cests        = `VESTS`,
		coat         = `COATS`,
		coatHeavy    = `COATS_HEAVY`,
		coatClosed   = `COATS_CLOSED`,
		cloak        = `CLOAKS`,
		poncho       = `PONCHOS`,
		dress        = `DRESSES`,
		skirt        = `SKIRTS`,
		pant         = `PANTS`,
		stockings    = `STOCKINGS`,
		chap         = `CHAPS`,
		suspender    = `SUSPENDERS`,
	
		-- Footwear
		boots        = `BOOTS`,
		spurs        = `BOOT_ACCESSORIES`,
		spats        = `SPATS`,
	
		-- Belts / Holsters / Ammo
		belt         = `BELTS`,
		buckle       = `BELT_BUCKLES`,
		gunbelt      = `GUNBELTS`,
		gunbeltaccs  = `GUNBELT_ACCS`,
		holster      = `HOLSTERS_LEFT`,
		loadouts     = `LOADOUTS`,
		ammopistol   = `AMMO_PISTOLS`,
		ammorifle    = `AMMO_RIFLES`,
	
		-- Accessories
		satchels     = `SATCHELS`,
		gloves       = `GLOVES`,
		gauntlets    = `GAUNTLETS`,
		eyewear      = `EYEWEAR`,
		necktie      = `NECKTIES`,
		neckwear     = `NECKWEAR`,
		bracelet     = `JEWELRY_BRACELETS`,
		badge        = `BADGES`,
		armor        = `ARMOR`,
		apron        = `APRONS`,
		accessories  = `ACCESSORIES`,
	
		-- Masks / Talismans
		mask         = `MASKS`,
		masklarge    = `MASKS_LARGE`,
		talismanhol  = `TALISMAN_HOLSTER`,
		talismanbelt = `TALISMAN_BELT`,
	}
	

    local gender     = data.gender == 0 and 'Male' or 'Female'
    local _gender    = data.gender == 0 and 'M' or 'F'
   -- local SkinColor  = Config.DefaultChar[SkinColorTracker]
    local albedo     = data.skinComp.albedo
    local material   = Config.texture_types[gender].material

    modules.IsPedReadyToRender()
    modules.ApplyShopItemToPed(data.skinComp.headtype)
    modules.ApplyShopItemToPed(data.skinComp.body)
    modules.ApplyShopItemToPed(data.skinComp.legs)
 --   Citizen.InvokeNative(0xC5E7204F322E49EB, albedo, joaat(SkinColor.Albedo[1]:format(_gender)), material)
    modules.UpdatePedVariation()

    modules.IsPedReadyToRender()

    for _, category in pairs(UndressCategories) do
        if modules.IsMetaPedUsingComponent(category) then -- IsMetaPedUsingComponentCategory
            RemoveTagFromMetaPed(PlayerPedId(), category, 0)
        end
    end

    modules.UpdatePedVariation()


end)

RegisterCommand('hat', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end
    
    if not IsClothingPartAvailableByName('hat') then 
        return 
    end

    local anim_data = {
        dict     = "ai_gestures@arthur@standing@speaker",
        name     = "greet_hat_tip_r_004",
        duration = 900,
        flag     = 1,
    }

    hat = not hat

    exports.tpz_core:getCoreAPI().PlayAnimation(PlayerPedId(), anim_data)
    Wait(500)
    PerformDressingStateActionByName('hat', 'HATS', hat)
end)


RegisterCommand('vest', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('vest') then 
        return 
    end

    vest = not vest

    PerformDressingStateActionByName('vest', 'VESTS', vest)

end)


RegisterCommand('boots', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('boots') then 
        return 
    end

    boots = not boots

    local anim_data = {
        dict     = "script_respawn@one_shot@fullbody@generic@unarmed@stand_boot_clean@a",
        name     = "respawn_action",
        duration = 500,
        flag     = 1,
    }

    exports.tpz_core:getCoreAPI().PlayAnimation(PlayerPedId(), anim_data)
    Wait(500)

    PerformDressingStateActionByName('boots', 'BOOTS', boots)

end)


RegisterCommand('pants', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('pant') then 
        return 
    end

    pants = not pants

    PerformDressingStateActionByName('pant', 'PANTS', pants)

end)


RegisterCommand('shirt', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('shirt') then 
        return 
    end

    shirt = not shirt

    PerformDressingStateActionByName('shirt', 'SHIRTS_FULL', shirt)

end)


RegisterCommand('gunbelt', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end
    
    if not IsClothingPartAvailableByName('gunbelt') then 
        return 
    end

    gunbelt = not gunbelt

    local anim_data = {
        dict     = "script_respawn@one_shot@fullbody@generic@unarmed@stand_adjust_belt@a",
        name     = "respawn_action",
        duration = 1000,
        flag     = 24,
    }

    exports.tpz_core:getCoreAPI().PlayAnimation(PlayerPedId(), anim_data)
    Wait(1000)

    PerformDressingStateActionByName('gunbelt', 'GUNBELTS', gunbelt)
end)


RegisterCommand('mask', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('mask') then 
        return 
    end

    mask = not mask

    local anim_data = {
        dict     = "mech_inventory@clothing@mask",
        name     = "face_2_satchel",
        duration = 1000,
        flag     = 24,
    }

    if not mask then 
        anim_data = {
            dict     = "mech_inventory@clothing@mask",
            name     = "satchel_2_face",
            duration = 2000,
            flag     = 24,
        }
    end

    exports.tpz_core:getCoreAPI().PlayAnimation(PlayerPedId(), anim_data)
    Wait(1000)

    PerformDressingStateActionByName('mask', 'MASKS', mask)

end)


RegisterCommand('coat', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('coat') then 
        return 
    end
    
    coat = not coat

    PerformDressingStateActionByName('coat', 'COATS', coat)
end)


RegisterCommand('closedcoat', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('coatclosed') then 
        return 
    end
    
    coatclosed = not coatclosed

    PerformDressingStateActionByName('coatclosed', 'COATS_CLOSED', coatclosed)
end)

RegisterCommand('cloak', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('cloak') then 
        return 
    end

    cloak = not cloak

    PerformDressingStateActionByName('cloak', 'CLOAKS', cloak)
end)

RegisterCommand('poncho', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('poncho') then 
        return 
    end

    poncho = not poncho

    PerformDressingStateActionByName('poncho', 'PONCHOS', poncho)

end)

RegisterCommand('eyewear', function()
    local PlayerData = GetCharacterData()

    if PlayerData.OnCharacterSelector or PlayerData.SelectedCharIdentifier == nil then
        exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_NOT_SELECTED"], 3000)
        return
    end

    if not IsClothingPartAvailableByName('eyewear') then 
        return 
    end

    eyewear = not eyewear
    
    local anim_data = {
        dict     = "amb_wander@code_human_wander@male@generic",
        name     = "wipe_eyes_02",
        duration = 1000,
        flag     = 24,
    }

    exports.tpz_core:getCoreAPI().PlayAnimation(PlayerPedId(), anim_data)
    Wait(1000)
    PerformDressingStateActionByName('eyewear', 'EYEWEAR', poncho)
end)
