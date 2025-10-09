-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

local function ContainsNumbersOrSymbols(name)
    -- If there's any number or any symbol (not a letter or space), return false
    if string.find(name, "%d") or string.find(name, "[^%a%s]") then
        return false
    end
    return true
end

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

ToggleUI = function(display, data)

    
    if display then 

        GetCharacterData().HasNUIActive = true

        CreateCharacterLobbyHandlers(0)
        --LoadAllClothingData() -- for loading player skin and all clothing properly.

        SetNuiFocus(display, display)
        SendNUIMessage({ type = "enable", enable = display })

        --PlayerData.HasNUIActive = false
        SendNUIMessage({ 
            action = 'set_information', 
            title = Locales['NUI_TITLE'], 
            locales = Locales,
        })

        SendNUIMessage({ 
            action = 'set_welcome_text', 
            text   = string.format(Locales['NUI_MAIN_PAGE_WELCOME'], "N/A")
        })

    else

        GetCharacterData().HasNUIActive = false

        SetNuiFocus(display, display)
        SendNUIMessage({ type = "enable", enable = display })
    end
end

SendNUINotification = function(message, messageType, duration)

    SendNUIMessage({ 
        action = 'sendNotification',
        notification_data = { 
            message = message, 
            type = messageType, 
            color = Config.NotificationColors[messageType], 
            duration = duration 
        },
    })

end
-----------------------------------------------------------
--[[ NUI Callbacks  ]]--
-----------------------------------------------------------

RegisterNUICallback('requestNotification', function(data)
    SendNUINotification(Locales[data.message], data.messageType, data.duration)
end)

-- triggered only once, for selecting the gender (male / female).
-- @param data.sex : returns the selected sex in uppercase (MALE / FEMALE)
RegisterNUICallback('select_sex', function(data)
    local isMale = data.sex == 'MALE' and true or false
    SelectCharacterModelOnCreation(isMale)

end)

RegisterNUICallback('save_identity', function(data)
    SetIdentityInformation(data)
end)

RegisterNUICallback('set_ageing_textures', function(data)
    UpdateCharacterAgeingTextures(data)
end)

RegisterNUICallback('set_height', function()
    UpdateCharacterHeight()
end)

RegisterNUICallback('set_body_type', function(data)
    UpdateCharacterBodyModifications(data)
end)

RegisterNUICallback('set_heritage_textures', function(data)
    UpdateCharacterHeritageModifications(data)
end)

RegisterNUICallback('request_clothing_categories', function()
    local Clothing = GetClothing()

    SendNUIMessage({ action = 'reset_categories' })

    for _, element in pairs (Config.ClothingCategories) do 

        if Clothing[element.category] then

            SendNUIMessage({
                action = 'insertCategory',
                result = element,
            })
            
        end

    end

    SendNUIMessage({ action = 'display_categories' })
end)

-- data.category, data.title
RegisterNUICallback('request_category_data', function(data)
    LoadSelectedCategoryClothingData(data.category, data.title)
end)

RegisterNUICallback('load_selected_cloth', function(data)
    LoadSelectedOutfitById(data, false)
end)

RegisterNUICallback('buy_item', function(data)
    BuySelectedCategoryItem(data)
end)

RegisterNUICallback('request_lifestyle_categories', function()
    SendNUIMessage({ action = 'reset_lifestyle_categories' })

    local elements = {
        { label = Locales['NUI_LIFESTYLES_MOLES'], category = 'moles' },
        { label = Locales['NUI_LIFESTYLES_SPOTS'], category = 'spots' },
        { label = Locales['NUI_LIFESTYLES_COMPLEX'], category = 'complex' },
        { label = Locales['NUI_LIFESTYLES_ACNE'], category = 'acne' },
        { label = Locales['NUI_LIFESTYLES_FRECKLES'], category = 'freckles' },
        { label = Locales['NUI_LIFESTYLES_DISCOLORATION'], category = 'disc' },
        { label = Locales['NUI_LIFESTYLES_SCARS'], category = 'scars' },
        { label = Locales['NUI_LIFESTYLES_GRIME'], category = 'grime' },
    }

    for _, element in pairs (elements) do 

        SendNUIMessage({
            action = 'insertLifestyleCategory',
            result = element,
        })
        
    end


end)

-- @data.category, @data.title
RegisterNUICallback('request_selected_lifestyle_data', function(data)
    LoadSelectedCategoryLifestyleData(data.category, data.title)
end)

RegisterNUICallback('set_lifestyle_textures', function(data)
    UpdateCharacterLifestyleTextures(data)
end)

RegisterNUICallback('request_bodyfeatures_categories', function()
    SendNUIMessage({ action = 'reset_bodyfeatures_categories' })

    local elements = {
        --{ label = Locales['NUI_BODY_FEATURES_TEETH'], category = 'teeth' },
        { label = Locales['NUI_BODY_FEATURES_JAW'], category = 'jaw' },
        { label = Locales['NUI_BODY_FEATURES_CHIN'], category = 'chin' },
        { label = Locales['NUI_BODY_FEATURES_HEAD'], category = 'head' },
        { label = Locales['NUI_BODY_FEATURES_NOSE'], category = 'nose' },
        { label = Locales['NUI_BODY_FEATURES_EARS'], category = 'ears' },
        { label = Locales['NUI_BODY_FEATURES_MOUTHANDLIPS'], category = 'mouthandlips' },
        { label = Locales['NUI_BODY_FEATURES_CHEEK'], category = 'cheek' },
        { label = Locales['NUI_BODY_FEATURES_EYESANDBROWS'], category = 'eyesandbrows' },
        { label = Locales['NUI_BODY_FEATURES_UPPERBODY'], category = 'upperbody' },
        { label = Locales['NUI_BODY_FEATURES_LOWERBODY'], category = 'lowerbody' },
    }

    for _, element in pairs (elements) do 

        SendNUIMessage({
            action = 'insertBodyFeaturesCategory',
            result = element,
        })
        
    end


end)


-- @data.category, @data.title
RegisterNUICallback('request_selected_bodyfeatures_data', function(data)
    LoadSelectedCategoryBodyFeaturesData(data.category, data.title)
end)

-- @data.category, data.value
RegisterNUICallback('set_bodyfeatures_textures', function(data)
    UpdateCharacterBodyFeaturesTextures(data)
end)


RegisterNUICallback('request_groom_categories', function()
    SendNUIMessage({ action = 'reset_groom_categories' })

    local elements = {
        { label = Locales['NUI_GROOM_HAIR'], category = 'hair' },
        { label = Locales['NUI_GROOM_OVERLAY'], category = 'overlay' },
    }

    if IdentityData.isMale then
        elements[#elements + 1] = {
            label = Locales['NUI_GROOM_BEARD'], 
            category = 'beard',
        }

        elements[#elements + 1] = {
            label = Locales['NUI_GROOM_BEARDSTABBLE'], 
            category = 'beardstabble',
        }
    else
        elements[#elements + 1] = {
            label = Locales['NUI_GROOM_BOW'], 
            category = 'bow',
        }
    end

    elements[#elements + 1] = {
        label = Locales['NUI_GROOM_EYEBROWS'], 
        category = 'eyebrows',
    }

    for _, element in pairs (elements) do 

        SendNUIMessage({
            action = 'insertGroomCategory',
            result = element,
        })
        
    end


end)


-- @data.category, @data.title
RegisterNUICallback('request_selected_groom_data', function(data)
    LoadSelectedCategoryGroomData(data.category, data.title)
end)

RegisterNUICallback('set_groom_textures', function(data)
    UpdateCharacterGroomTextures(data)
end)


RegisterNUICallback('request_makeup_categories', function()
    SendNUIMessage({ action = 'reset_makeup_categories' })

    local elements = {
        { label = Locales['NUI_MAKEUP_FOUNDATION'], category = 'foundation' },
        { label = Locales['NUI_MAKEUP_LIPSTICKS'],  category = 'lipsticks' },
        { label = Locales['NUI_MAKEUP_SHADOWS'],    category = 'shadows' },
        { label = Locales['NUI_MAKEUP_EYELINERS'],  category = 'eyeliners' },
        { label = Locales['NUI_MAKEUP_BLUSH'],      category = 'blush' },
    }

    for _, element in pairs (elements) do 

        SendNUIMessage({
            action = 'insertMakeupCategory',
            result = element,
        })
        
    end


end)

-- @data.category, @data.title
RegisterNUICallback('request_selected_makeup_data', function(data)
    LoadSelectedCategoryMakeupData(data.category, data.title)
end)

RegisterNUICallback('set_makeup_textures', function(data)
    UpdateCharacterMakeupTextures(data)
end)


RegisterNUICallback('request_eye_textures', function()
    RequestEyeTextures()
end)

RegisterNUICallback('set_eye_textures', function(data)
    UpdateCharacterEyeTextures(data)
end)

RegisterNUICallback('key_action', function(data)
    
    local playerPed = PlayerPedId()

    -- Pressed right key.
    if data.action == 'ROTATE_LEFT' then
        Heading = Heading - 2.5
        SetPedDesiredHeading(PlayerPedId(), Heading)
    end

    -- Pressed left key.
    if data.action == 'ROTATE_RIGHT' then
		Heading = Heading + 2.5
		SetPedDesiredHeading(PlayerPedId(), Heading)
    end

    -- UP CAMERA
    if data.action == 'UP_CAMERA' then

        if CameraHandler.coords.z <= CameraHandler.z then

            CameraHandler.coords.z = CameraHandler.coords.z + 0.01
            StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
            CameraHandler.coords.rotz, CameraHandler.zoom)

        end

    end

    -- DOWN CAMERA
    if data.action == 'DOWN_CAMERA' then

        if CameraHandler.coords.z >= CameraHandler.z - 1.0 then

            CameraHandler.coords.z = CameraHandler.coords.z - 0.01

            StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
            CameraHandler.coords.rotz, CameraHandler.zoom)

        end
    end

    if data.action == 'ZOOM_OUT' then

        if CameraHandler.zoom < 47.5 then -- Zoom out limit

            CameraHandler.zoom = CameraHandler.zoom + 0.5

            StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
            CameraHandler.coords.rotz, CameraHandler.zoom)
        end
    end

    if data.action == 'ZOOM_IN' then

        if CameraHandler.zoom > 11.0 then -- Zoom in limit
            

            CameraHandler.zoom = CameraHandler.zoom - 0.5

            StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
            CameraHandler.coords.rotz, CameraHandler.zoom)
        end

    end

    -- Pressed X key.
    if data.action == 'HANDS_UP_DOWN' then

        local dict = Config.OnCharacterCreate.HandsUpAnimation.Dict
        local body = Config.OnCharacterCreate.HandsUpAnimation.Body

        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Citizen.Wait(100)
        end

        if IsEntityPlayingAnim(playerPed, dict, body, 3) then
            ClearPedTasks(playerPed)
            RemoveAnimDict(dict)
            TaskStandStill(playerPed, -1)
            
        else
            TaskPlayAnim(playerPed, dict, body, 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
        end

        Wait(500)

    end

    if data.action == 'DRESSING' then
        SetCharacterDressingState()
    end
end)

RegisterNUICallback('create', function()
    --IdentityData = { isMale = true, firstname = nil, lastname = nil, dob = nil }

    if IdentityData.firstname == nil or IdentityData.lastname == nil or IdentityData.dob == nil then
        SendNUINotification(Locales['CREATE_CHARACTER_INVALID_IDENTIFICATION'], 'error', 4000)
        return
    end

    local firstNameValid = ContainsNumbersOrSymbols(IdentityData.firstname)

    if not firstNameValid then
        SendNUINotification(Locales['CREATE_CHARACTER_INVALID_FIRSTNAME'], 'error', 4000)
        return
    end


    local lastNameValid = ContainsNumbersOrSymbols(IdentityData.lastname)

    if not lastNameValid then
        SendNUINotification(Locales['CREATE_CHARACTER_INVALID_LASTNAME'], 'error', 4000)
        return
    end

    -- Checking blacklisted names.
    local isInputPermitted = true
    for index, name in pairs (Config.BlacklistedNames) do

        if IdentityData.firstname == name or IdentityData.lastname == name then
            isInputPermitted = false
        end
    end

    if not isInputPermitted then
        SendNUINotification(Locales['CREATE_CHARACTER_BLACKLISTED_FIRST_OR_LASTNAME'], 'error', 5000)
        return
    end

    local dob = exports.tpz_core:getCoreAPI().Split(IdentityData.dob, "/")

    local year = tonumber(dob[3])

    if year < Config.YearInputs.min or year > Config.YearInputs.max then
        SendNUINotification(string.format(Locales['CREATE_CHARACTER_NOT_PERMITTED_YEAR'], Config.YearInputs.min, Config.YearInputs.max), 'error', 5000)
        return
    end

    ToggleUI(false)
    GetCharacterData().OnCharacterSelector = true
    
    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(2000)
    end

    Wait(2000)

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
        
    NetworkEndTutorialSession()
        
    local sex = IdentityData.isMale and 0 or 1

    TriggerServerEvent('tpz_core:createNewCharacter', IdentityData.firstname, IdentityData.lastname, sex, IdentityData.dob, GetPlayerSkinData())
    TriggerServerEvent('tpz_core:instanceplayers', 0) -- Removing all the instanced players after selecting a character.
end)
