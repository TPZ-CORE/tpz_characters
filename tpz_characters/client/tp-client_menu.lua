---@diagnostic disable: undefined-global
MenuData = {}

TriggerEvent("tpz_menu_base:getData", function(call)
    MenuData = call
end)

IsPlayInCharMenu             = false

ClothingList           = {}

local loadedRequiredCharData = false


function OpenCharacterCustomization()
    IsPlayInCharMenu = true

    local _player = PlayerPedId()
    TaskStandStill(_player, -1)

    local sex = getGender()

    Wait(250)
    
    if not loadedRequiredCharData then

        loadedRequiredCharData = true

        LoadSelectedListResults(sex)
        
        for key, value in pairs(MP.OverlayAllLayers) do
            if MP.CustomizationOverlayElements[key] then
    
                local overlayKeyData = MP.CustomizationOverlayElements[key]
    
                SkinData[string.lower(overlayKeyData.txt_id)]  = -1
                SkinData[string.lower(overlayKeyData.opacity)] = 0
                SkinData[string.lower(overlayKeyData.vis)] = 0
            end
        end
    
    
        for key, value in pairs(MP.Overlays) do
    
            if MP.MakeupOverlayTypes[key] then
                
                local overlay = MP.MakeupOverlayTypes[key]

                SkinData[overlay.txt_id] = -1
                SkinData[overlay.color] = 0

                if overlay.color2 and overlay.color3 then
                    SkinData[overlay.color2] = 0
                    SkinData[overlay.color3] = 0
                end

                if overlay.variant then
                    SkinData[overlay.variant] = 0
                end

                SkinData[overlay.opacity] = 0
                SkinData[overlay.visibility] = 0
            end
    
        end

    end

    local elements = {

        { label = Locales['MAIN_MENU']['GENERAL'].label,       value = "facials",  desc = Locales['MAIN_MENU']['GENERAL'].desc },
        { label = Locales['MAIN_MENU']['FACE_OVERLAYS'].label, value = "overlays", desc = Locales['MAIN_MENU']['FACE_OVERLAYS'].desc, },
        { label = Locales['MAIN_MENU']['AGEING'].label,        value = "ageing",   desc = Locales['MAIN_MENU']['AGEING'].desc, },
        { label = Locales['MAIN_MENU']['MAKEUP'].label,        value = "makeup",   desc = Locales['MAIN_MENU']['MAKEUP'].desc, },
        { label = Locales['MAIN_MENU']['CLOTHING'].label,      value = "clothing", desc = Locales['MAIN_MENU']['CLOTHING'].desc, },
        { label = Locales['MAIN_MENU']['FINISH'].label,        value = "finish",   desc = Locales['MAIN_MENU']['FINISH'].desc, },

    }

    MenuData.Open('default', GetCurrentResourceName(), 'main',

    {
        title = RegisterData.firstname .. " " .. RegisterData.lastname,

        subtext = MP.CustomizationTitle,
        align = "top-left",
        elements = elements,
        lastmenu = "notMenu"
    },

    function(data, menu)
        if data.current.value == "facials" then
            OpenCharacterCustomizationTypes(data.current.value)
                        
        elseif data.current.value == 'overlays' then
            OpenCharacterCustomizationOverlays()

        elseif data.current.value == "ageing" then
            OpenCharacterAgeingCustomization()

        elseif data.current.value == "makeup" then
            OpenCharacterMakeupCustomization()


        elseif data.current.value == "clothing" then
            OpenCharacterCustomizationTypes(data.current.value)

        elseif data.current.value == "finish" then

            MenuData.CloseAll()
            
            while not IsScreenFadedOut() do
                Wait(50)
                DoScreenFadeOut(2000)
            end

            ClearPedTasksImmediately(PlayerPedId(), true)
            DestroyAllCams(true)

            CurrentCharCreateCoords = nil

            CameraHandler           = {coords = nil, zoom = 0, z = 0 }
            IsPlayInCharMenu        = false

            ClothingList            = {}

            NetworkClearClockTimeOverride()
            exports.weathersync:setSyncEnabled(true)

            ExecuteCommand("hud:hideall")

            Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")

            SetEntityInvincible(PlayerPedId(), false)
            SetEntityCanBeDamaged(PlayerPedId(), true)
            TaskStandStill(PlayerPedId(), 1)

            GetCharacterData().IsBusy = false
            GetCharacterData().OnCharacterSelector = false

            DeleteCharacterEntities()
            ClearSelectorPrompt()

            TriggerServerEvent('tpz_core:createNewCharacter', RegisterData.firstname, RegisterData.lastname, RegisterData.gender, RegisterData.dob, SkinData, "unemployed")
            TriggerServerEvent('tpz_core:instanceplayers', 0) -- Removing all the instanced players after selecting a character.
      
        end

    end,

    function(data, menu)
        menu.close()
    end)

end

function OpenCharacterCustomizationTypes(actionType)
    MenuData.CloseAll()

    local _player = PlayerPedId()

    Wait(150)

    local finished = false
    local elements = {}

    for _, element in pairs (MP.CustomizationElements) do

        if actionType == element.action and ClothingList[element.tag] then

            element.desc = Locales['TOTAL_TYPES'] .. ' ' .. element.label .. " : " .. ClothingList[element.tag].max
            
            if not element.sex then

                element.value = ClothingList[element.tag].current
                element.max = ClothingList[element.tag].max

                table.insert(elements, element)
    
            elseif element.sex and element.sex == tonumber(SkinData['sex']) then

                element.value = ClothingList[element.tag].current
                element.max = ClothingList[element.tag].max
                
                table.insert(elements, element)
            end

        end

        if next(MP.CustomizationElements, _) == nil then
            finished = true
        end
    end

    while not finished do
        Wait(100)
    end

    MenuData.Open('default', GetCurrentResourceName(), 'sub_' .. actionType,

        {
            title = RegisterData.firstname .. " " .. RegisterData.lastname,

            subtext = MP.CustomizationTitle,
            align = "top-left",
            elements = elements,
            lastmenu = "OpenCharacterCustomization"
        },

        function(data, menu)

            if (data.current == "backup") then
                OpenCharacterCustomization()
                menu.close()
                return
            end

            for index, el in pairs (elements) do

                if data.current.tag == el.tag and tonumber(data.current.value) < tonumber(data.current.max) then

                    if data.current.value <= 0 then

                        local tag = data.current.tag

                        if tag == "waist"  or tag == "bodies_full" then

                            Citizen.InvokeNative(0x1902C4CFCC5BE57C, _player, -2045421226)
                            UpdateVariation(_player)
                            SkinData[tag] = -1
                            
                        elseif tag == "heads" or tag == "eyes" or tag == "bodies_upper" or tag == "legs" then

                            local sex = getGender()

                            ApplyShopItemToPed(_player, MP.DefaultCustomization[sex][tag])
                            UpdateVariation(_player)

                            SkinData[tag] = -1
                        else
                            Citizen.InvokeNative(0xD710A5007C2AC539, _player, MP.DefaultHashList[tag], 0)
                            UpdateVariation(_player)
                            SkinData[tag] = -1
                        end

                    elseif data.current.value > 0 then

                        local tag = data.current.tag

                        local clothingData = ClothingList[tag].list[data.current.value]
                        local hash = clothingData.hash

                        ClothingList[tag].current = data.current.value
                        SkinData[tag] = clothingData.hashDecSigned

                        if tag == "waist" or tag == "bodies_full" then
                            
                           -- local clothingData = ClothingList[tag .. "-" .. data.current.value]
                            --local hash = clothingData.hash

                            Citizen.InvokeNative(0x1902C4CFCC5BE57C, _player, hash)
                            --UpdateVariation(_player)
                            
                            --SkinData[string.lower(tag)] = clothingData.index
                        else 

                            --local clothingData = ClothingList[tag .. "-" .. data.current.value]
                            --local hash = clothingData.hash

                           ApplyShopItemToPed(_player, hash)

                            if Config.Debug then
                                print("changed " .. tag .. ", to the following Hash Dec Signed: " .. clothingData.hashDecSigned )
                            end

                            --SkinData[string.lower(tag)] = clothingData.index
    
                        end

                        UpdateVariation(_player)
    
                    end
                end

            end


        end,
    function(data, menu)
        TaskStandStill(PlayerPedId(), 1)
        InMembersManagementMenu = false
        menu.close()
    end)
end


function OpenCharacterCustomizationOverlays()
    MenuData.CloseAll()

    local _player  = PlayerPedId()
    local elements = {}

    for key, value in pairs(MP.Overlays) do
        if MP.CustomizationOverlayElements[key] then

            local overlayKeyData = MP.CustomizationOverlayElements[key]
            -- *texture
            table.insert(elements, {
                label = overlayKeyData.label,
                value = 0,
                min = 0,
                max = #value,
                type = "slider",
                txt_id = overlayKeyData.txt_id,
                opac = overlayKeyData.opacity,
                visibility = overlayKeyData.vis,
                desc = Locales['TOTAL_TYPES'] .. " " .. overlayKeyData.label .. " : " .. #value,
                name = key,
                tag = "texture"
            })

            if MP.ColorPalettes[key] then

                table.insert(elements, {
                    label = overlayKeyData.label .. ' ' .. Locales['FACE_OVERLAYS']['COLORS'],
                    value = 0,
                    min = 0,
                    max = #MP.ColorPalettes[key],
                    comp = MP.ColorPalettes[key],
                    type = "slider",
                    txt_id = overlayKeyData.txt_id,

                    opac = overlayKeyData.opacity,
                    color = overlayKeyData.color,
                    visibility = overlayKeyData.vis,
                    desc = Locales['TOTAL_COLORS'] .. #MP.ColorPalettes[key],
                    name = key,
                    tag = "color"
                })

            end


            --* opacity
            table.insert(elements, {
                label = overlayKeyData.label .. " " .. Locales['FACE_OVERLAYS']['OPACITY'],
                value = 0,
                min = 0,
                max = 10,
                type = "slider",
                txt_id = overlayKeyData.txt_id,
                opac = overlayKeyData.opacity,
                visibility = overlayKeyData.vis,
                desc = "Max : 0-10 - (0.1 - 1.0)",
                name = key,
                tag = "opacity"
            })
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'sub_overlays',
    {
        title = RegisterData.firstname .. " " .. RegisterData.lastname,
        subtext = MP.CustomizationTitle,
        align = "top-left",
        elements = elements,
        lastmenu = "OpenCharacterCustomization"
    },

    function(data, menu)

        if (data.current == "backup") then
            OpenCharacterCustomization()
            menu.close()
            return
        end

        if data.current.tag == "texture" then
            
            if data.current.name == "eyebrows" then

                if data.current.value > 0 then

            
                    SkinData[data.current.visibility] = 1
                    SkinData[data.current.txt_id] = data.current.value
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], SkinData[data.current.txt_id], 1, 0, 0, 1.0, 0, 1, SkinData[data.current.color], 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                else
    
                    SkinData[data.current.visibility] = 0
                    SkinData[data.current.txt_id] = -1
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], 1, 0, 0, 1, 1.0, 0, 1, SkinData[data.current.opcolorac], 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                end

            else

                if data.current.value > 0 then

            
                    SkinData[data.current.visibility] = 1
                    SkinData[data.current.txt_id] = data.current.value
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], SkinData[data.current.txt_id], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                else
    
                    SkinData[data.current.visibility] = 0
                    SkinData[data.current.txt_id] = -1
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], 0, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                end

            end
        end
    

        if data.current.tag == "color" then

            if data.current.name == "eyebrows" then
                if data.current.value > 0 then

                    SkinData[data.current.visibility] = 1
                    SkinData[data.current.color] = data.current.value
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],SkinData[data.current.txt_id], 1, 0, 0, 1.0, 0, 1, data.current.value, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                else
    
                    SkinData[data.current.visibility] = 0
                    SkinData[data.current.color] = -1
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], SkinData[data.current.txt_id], 1, 0, 0, 1.0, 0, 1, 0, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                end
            end
        end

        if data.current.tag == "opacity" then

            if data.current.name == "eyebrows" then
                if data.current.value > 0 then

                    SkinData[data.current.visibility] = 1
                    SkinData[data.current.opac] = data.current.value / 10
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],SkinData[data.current.txt_id], 1, 0, 0, 1.0, 0, 1, SkinData[data.current.color], 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                else
    
                    SkinData[data.current.visibility] = 0
                    SkinData[data.current.opac] = 0
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], SkinData[data.current.txt_id], 1, 0, 0, 1.0, 0, 1, SkinData[data.current.color], 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                end

            else

                if data.current.value > 0 then

                    SkinData[data.current.visibility] = 1
                    SkinData[data.current.opac] = data.current.value / 10
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],SkinData[data.current.txt_id], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                else
    
                    SkinData[data.current.visibility] = 0
                    SkinData[data.current.opac] = 0
                    toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility], SkinData[data.current.txt_id], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData[data.current.opac], SkinData['albedo'] )
                end
            end
        end
    end, function(data, menu)

    end)
end

function OpenCharacterAgeingCustomization()
    MenuData.CloseAll()

    local _player = PlayerPedId()

    local elements = {
        {
            label = Locales['AGEING']['TYPES'],
            type = "slider",
            min = 0,
            info = MP.OverlayAllLayers,
            comp = MP.OverlayAllLayers,
            compname = MP.OverlayAllLayers[9].name,
            max = #MP.Overlays['ageing'],
            value = 0,
            desc = Locales['TOTAL_TYPES'] .. " : " .. #MP.Overlays['ageing']
        },
        {
            label = Locales['AGEING']['OPACITY'],
            type = "slider",
            value = 0,
            info = nil,
            comp = MP.OverlayAllLayers,
            min = 0,
            max = 10,
            desc = "Max : 0-10 - (0.1 - 1.0)",
        },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title = RegisterData.firstname .. " " .. RegisterData.lastname,
            subtext = MP.CustomizationTitle,
            align = "top-left",
            elements = elements,
            lastmenu = "OpenCharacterCustomization"
        },

        function(data, menu)

            if (data.current == "backup") then
                OpenCharacterCustomization()
                menu.close()
                return
            end

            if data.current.type == "slider" and not data.current.info then -- * opacity

                if data.current.value > 0 then

                    SkinData['ageing_opacity'] = data.current.value / 10
                    SkinData['ageing_visibility'] = 1

                    toggleOverlayChange(_player, "ageing", 1, SkinData['ageing_tx_id'], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData['ageing_opacity'], SkinData['albedo'])
                else
                    SkinData['ageing_visibility'] = 0

                    if SkinData['ageing_tx_id'] == 1 then
                        SkinData['ageing_tx_id'] = 0
                    end
                end
            end

            if data.current.type == "slider" and data.current.info then -- * texture id

                if data.current.value > 0 then
                    SkinData['ageing_tx_id'] = data.current.value
                    toggleOverlayChange(_player, "ageing", SkinData['ageing_visibility'], SkinData['ageing_tx_id'], 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData['ageing_opacity'], SkinData['albedo'])
                else
                    SkinData['ageing_tx_id'] = -1
                    toggleOverlayChange(_player, "ageing", SkinData['ageing_visibility'], 0, 0, 0, 1, 1.0, 0, 0, 0, 0, 0, 1, SkinData['ageing_opacity'], SkinData['albedo'])
                end
            end
        end, function(data, menu)

    end)

end


function OpenCharacterMakeupCustomization()
    MenuData.CloseAll()

    local _player = PlayerPedId()

    local elements = {}

    for key, value in pairs(MP.Overlays) do

        if MP.MakeupOverlayTypes[key] then
            
            local overlay = MP.MakeupOverlayTypes[key]

            -- *texture
            table.insert(elements, {
                label = overlay.label .. ' ' .. Locales['MAKEUP']['TEXTURES'],
                value = SkinData[overlay.txt_id],
                min = 0,
                max = #value,
                type = "slider",
                txt_id = overlay.txt_id,
                opac = overlay.opacity,
                color = overlay.color,
                variant = overlay.variant,
                visibility = overlay.visibility,
                desc = Locales['TOTAL_TYPES'] .. " " .. overlay.label .. " : " .. #value,
                name = key,
                tag = "texture"
            })

            --*Color
            local ColorValue = 0
            for x, color in pairs(MP.ColorPalettes[key]) do
                if GetHashKey(color) == SkinData[overlay.color] then
                    ColorValue = x
                end
            end

            table.insert(elements, {
                label = overlay.label .. ' ' .. Locales['MAKEUP']['COLORS'],
                value = ColorValue,
                min = 0,
                max = 10,
                comp = MP.ColorPalettes[key],
                type = "slider",
                txt_id = overlay.txt_id,
                opac = overlay.opacity,
                color = overlay.color,
                visibility = overlay.visibility,
                variant = overlay.variant,
                desc = Locales['TOTAL_TYPES'] .. " " .. overlay.label .. " : " .. 10,
                name = key,
                tag = "color"
            })

            -- if key == "lipsticks" or key == "eyeliners" then
            if key == "lipsticks" then
                local Color2Value = 0
                for x, color in pairs(MP.ColorPalettes[key]) do
                    if GetHashKey(color) == SkinData[overlay.color2] then
                        Color2Value = x
                    end
                end

                --*Color 2
                table.insert(elements, {
                    label = overlay.label .. ' ' .. Locales['MAKEUP']['SECONDARY_COLORS'],
                    value = Color2Value,
                    min = 0,
                    max = 10,
                    type = "slider",
                    comp = MP.ColorPalettes[key],
                    txt_id = overlay.txt_id,
                    opac = overlay.opacity,
                    color = overlay.color,
                    color2 = overlay.color2,
                    color3 = overlay.color3,
                    variant = overlay.variant,
                    visibility = overlay.visibility,
                    desc = Locales['TOTAL_TYPES'] .. " " .. overlay.label .. " : " .. 10,
                    name = key,
                    tag = "color2"
                })
            end

            if key == "lipsticks" or key == "shadows" or key == "eyeliners" then
                --*Variant
                table.insert(elements, {
                    label = overlay.label .. ' ' .. Locales['MAKEUP']['VARIANTS'],
                    value = SkinData[overlay.variant] or 0,
                    min = 0,
                    max = overlay.varvalue,
                    type = "slider",
                    comp = MP.ColorPalettes[key],
                    txt_id = overlay.txt_id,
                    opac = overlay.opacity,
                    color = overlay.color,
                    color2 = overlay.color2,
                    color3 = overlay.color3,
                    variant = overlay.variant,
                    visibility = overlay.visibility,
                    desc = Locales['TOTAL_TYPES'] .. " " .. overlay.label .. " : " .. overlay.varvalue,
                    name = key,
                    tag = "variant"
                })
            end

            --* opacity
            table.insert(elements, {
                label = overlay.label .. ' ' .. Locales['MAKEUP']['OPACITY'],
                value = SkinData[overlay.opacity],
                min = 0,
                max = 0.9,
                hop = 0.1,
                type = "slider",
                txt_id = overlay.txt_id,
                opac = overlay.opacity,
                color = overlay.color,
                variant = overlay.variant,
                visibility = overlay.visibility,
                desc = Locales['TOTAL_TYPES'] .. " " .. overlay.label .. " : 0.9",
                name = key,
                tag = "opacity"
            })
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'sub_makeup',
        {
            title = RegisterData.firstname .. " " .. RegisterData.lastname,
            subtext = MP.CustomizationTitle,
            align = "top-left",
            elements = elements,
            lastmenu = "OpenCharacterCustomization"
        },

        function(data, menu)
            --* Go back
            if (data.current == "backup") then
                OpenCharacterCustomization()
                menu.close()
                return
            end

            if data.current.tag == "texture" then
                --* texture id
                if data.current.value <= 0 then
                    SkinData[data.current.visibility] = 0
                else
                    SkinData[data.current.visibility] = 1
                end
                SkinData[data.current.txt_id] = data.current.value
                toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],
                    SkinData[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, SkinData[data.current.color], SkinData[data.current.color2] or 0,
                    SkinData[data.current.color3] or 0, SkinData[data.current.variant] or 1,
                    SkinData[data.current.opac], SkinData.albedo)
            end

            if data.current.tag == "color" then
                --* color
                SkinData[data.current.color] = data.current.comp[data.current.value]
                toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],
                    SkinData[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, SkinData[data.current.color], SkinData[data.current.color2] or 0,
                    SkinData[data.current.color3] or 0, SkinData[data.current.variant] or 1,
                    SkinData[data.current.opac], SkinData.albedo)
            end

            if data.current.tag == "color2" then
                --* color secondary
                SkinData[data.current.color2] = data.current.comp[data.current.value]
                toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],
                    SkinData[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, SkinData[data.current.color], SkinData[data.current.color2] or 0,
                    SkinData[data.current.color3] or 0, SkinData[data.current.variant] or 1, SkinData
                    [data.current.opac], SkinData.albedo)
            end

            if data.current.tag == "variant" then
                --* variant
                SkinData[data.current.variant] = data.current.value
                toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],
                    SkinData[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, SkinData[data.current.color], SkinData[data.current.color2] or 0,
                    SkinData[data.current.color3] or 0, SkinData[data.current.variant] or 1,
                    SkinData[data.current.opac], SkinData.albedo)
            end

            if data.current.tag == "opacity" then
                --* opacity
                if data.current.value <= 0 then
                    SkinData[data.current.visibility] = 0
                else
                    SkinData[data.current.visibility] = 1
                end

                SkinData[data.current.opac] = data.current.value
                toggleOverlayChange(_player, data.current.name, SkinData[data.current.visibility],
                    SkinData[data.current.txt_id], 1, 0, 0,
                    1.0, 0, 1, SkinData[data.current.color], SkinData[data.current.color2] or 0,
                    SkinData[data.current.color3] or 0, SkinData[data.current.variant] or 1,
                    SkinData[data.current.opac], SkinData.albedo)
            end
        end, function(data, menu)

        end)
end
-----------------------------------------------------------
--[[ Menu Utility Functions  ]]--
-----------------------------------------------------------

function LoadSelectedListResults(sex) 

    ClothingList = nil
    ClothingList = {}

    for index, type in pairs (ClothHashNames) do

        if type.is_multiplayer and type.ped_type == sex and type.category_hashname ~= nil and type.category_hashname ~= "" then

            if not MP.BlackListedHashDecSigns[type.hash_dec_signed] then

                local _type = string.lower(type.category_hashname)

                if ClothingList[_type] == nil then
                    SkinData[_type]             = -1

                    ClothingList[_type]         = {}
                    ClothingList[_type].tag     = _type

                    ClothingList[_type].list    = {}
                    ClothingList[_type].max     = 0
                    ClothingList[_type].current = -1
                end

                ClothingList[_type].max = ClothingList[_type].max + 1

                ClothingList[_type].list[ClothingList[_type].max]               = {}
                ClothingList[_type].list[ClothingList[_type].max].hash          = type.hash
                ClothingList[_type].list[ClothingList[_type].max].hashDecSigned = tonumber(type.hash_dec_signed)

                ClothingList[tonumber(type.hash_dec_signed)] = type.hash

                -- Register all available types into player skin even if the player character does not have.

                if MP.DefaultCustomization[sex][_type] then 

                    local customization = string.upper(MP.DefaultCustomization[sex][_type])

                    if customization == string.upper(type.hash) or tonumber(customization) == tonumber(type.hash_dec_signed) then 
                     
                        ClothingList[_type].current = ClothingList[_type].max
                        SkinData[_type]             = tonumber(type.hash_dec_signed)
                    
                    end

                end

            end

        end

    end

end

