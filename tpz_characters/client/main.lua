
local CharacterData = {
    PositionIndex       = 0,

    Characters          = 0,
    MaxCharacters       = 3,

    OnCharacterSelector = false,

    IsBusy              = true, -- for radar.

    SelectedCharIndex   = 0,
    SelectedCharIdentifier = nil, -- selected char on select prompt
    
    Data                = {},

    HasNUIActive        = false,
}

CameraHandler = {coords = nil, zoom = 0, z = 0 }
IdentityData  = { isMale = true, firstname = nil, lastname = nil, dob = nil }

local LOADED_FIRST_CHAR = false 
local CHARACTER_CHANGE_AWAIT = false
local REQUESTED_JOIN_DATA = false

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

-- Function to clean the character properly
function CleanPlayerPed()
    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
        -- Clean blood and dirt
        ClearPedBloodDamage(playerPed)
        ClearPedEnvDirt(playerPed)
        ClearPedWetness(playerPed)
        ClearPedDamageDecalByZone(playerPed, 10, "ALL")
        
        -- Nearby
        local coords = GetEntityCoords(playerPed)
        RemoveDecalsInRange(coords.x, coords.y, coords.z, 2.0)
    end
end

function CheckControls(func, pad, controls)
	if type(controls) == 'number' then
		return func(pad, controls)
	end

	for _, control in ipairs(controls) do
		if func(pad, control) then
			return true
		end
	end

	return false
end


function UpdateCharacterSelectorControls()

    local hasCharacters = CharacterData.Characters > 0
    local canChangeCharacter = CharacterData.Characters > 1
    local canCreateCharacter = CharacterData.Characters < CharacterData.MaxCharacters

    SendNUIMessage({
        action = "updateSelectorControls",

        previous = canChangeCharacter,
        next = canChangeCharacter,
        select = hasCharacters,
        delete = hasCharacters,
        create = canCreateCharacter
    })

end

function GetCharacterData()
    return CharacterData
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

-- on player join
RegisterNetEvent('tpz_core:playerJoining')
AddEventHandler("tpz_core:playerJoining", function(userData)

    if userData == nil or userData.max_chars == nil then
        CharacterData.MaxCharacters = exports.tpz_core:getCoreAPI().GetConfig().MaxCharacters
    else
        CharacterData.MaxCharacters = userData.max_chars
    end

    if Config.Debug then
        print(string.format("Maximum Characters Limit: %s", CharacterData.MaxCharacters))
    end

    REQUESTED_JOIN_DATA = true 

    TriggerServerEvent('tpz_core:onPlayerJoined')

end)

-- Added by @Dobiban
RegisterNetEvent('tpz_characters:receiveSkinData')
AddEventHandler('tpz_characters:receiveSkinData', function(data)
    
    local playerPed = PlayerPedId()
    local currentHealth = GetEntityHealth(playerPed)
    local gender = data.gender == 0 and "mp_male" or "mp_female"

    if Config.Debug then
        print('[TPZ-CHARACTERS] Current health saved:', currentHealth)
        print('[TPZ-CHARACTERS] Loading model:', gender)
    end


    LoadHashModel(joaat(gender))
    Wait(500)
    
    if Config.Debug then
        print('[TPZ-CHARACTERS] Applying model')
    end

    SetPlayerModel(gender)
    SetModelAsNoLongerNeeded(joaat(gender))
    Wait(500)
    
    if Config.Debug then
        print('[TPZ-CHARACTERS] Loading components')
    end

    LoadEntityComponents(PlayerPedId(), gender, data.skinComp, true, true)

    -- Restaurar vida e limpar ped
    Wait(1000)
    SetEntityHealth(PlayerPedId(), currentHealth)

    if Config.Debug then
        print('[TPZ-CHARACTERS] Skin reloaded successfully')
    end

    exports.tpz_core:getCoreAPI().NotifyObjective(Locales["CHARACTER_RELOADED"], 3000)

end)



function GetNearbyObjects(coords)
	local itemset = CreateItemset(true)
	local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, 1.5, itemset, 3, Citizen.ResultAsInteger())

	local objects = {}

	if size > 0 then
		for i = 0, size - 1 do
			table.insert(objects, GetIndexedItemInItemset(i, itemset))
		end
	end

	if IsItemsetValid(itemset) then
		DestroyItemset(itemset)
	end

	return objects
end

-- Load character selection
RegisterNetEvent('tpz_characters:loadCharacterSelection')
AddEventHandler('tpz_characters:loadCharacterSelection', function(chars, data)

    CharacterData.Characters = chars
    CharacterData.Data       = data

    while not DoesEntityExist(PlayerPedId()) do 
        Wait(500)
    end

    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(1000)
    end

    CharacterData.IsBusy = true 

    local instanced = GetPlayerServerId(PlayerId()) + 456565
	TriggerServerEvent('tpz_core:instanceplayers', math.floor(instanced)) 

    local randomPosition = Config.OnCharacterSelector.Locations[ math.random( #Config.OnCharacterSelector.Locations ) ]

    CharacterData.PositionIndex = randomPosition.Index

    local spawnCoords = randomPosition.CharacterPositions[1].SpawnPosition
    exports.tpz_core:getCoreAPI().TeleportToCoords(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.h)

    -- Request Coords Teleportation Collision
    if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
        RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
    end

    repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())

    ExecuteCommand('hud:hideall') -- tpz_hud

    exports.weathersync:setSyncEnabled(false)
	exports.weathersync:setMyWeather(randomPosition.Modifications.Weather.Type, randomPosition.Modifications.Weather.Transition,  randomPosition.Modifications.Weather.Snow)
	exports.weathersync:setMyTime(randomPosition.Modifications.ClockTime.Hour, 0, 0, randomPosition.Modifications.ClockTime.Transition, true)

    SetTimecycleModifier(randomPosition.Modifications.Timecycle.ModifierName)
	Citizen.InvokeNative(0xFDB74C9CC54C3F37, randomPosition.Modifications.Timecycle.Strength)

    -- Request Music
    PrepareMusicEvent(randomPosition.Modifications.Music)
	Wait(100)
	TriggerMusicEvent(randomPosition.Modifications.Music)
	Wait(1000)

    CreateThread(function()

        local pool = GetGamePool("CPed") -- clearing peds that are inside the interior / exterior.
        for _,npc in pairs (pool) do

            if DoesEntityExist(npc) and not IsPedAPlayer(npc) then
                DeleteEntity(npc)
            end

        end

        while CharacterData.IsBusy do
    
            Wait(0)

            DisplayRadar(false)
    
            Citizen.InvokeNative(0xAB0D553FE20A6E25, 0.0) -- SetAmbientPedDensityMultiplierThisFrame
            Citizen.InvokeNative(0x7A556143A1C03898, 0.0) -- SetScenarioPedDensityMultiplierThisFrame
            Citizen.InvokeNative(0xBA0980B5C0A11924, 0.0) -- SetAmbientHumanDensityMultiplierThisFrame
            Citizen.InvokeNative(0x28CB6391ACEDD9DB, 0.0) -- SetScenarioHumanDensityMultiplierThisFrame

            if not LOADED_FIRST_CHAR then 
                DoScreenFadeOut(0)
            end
   
        end
    
    end)

    -- Modify Player Attributes
	--FreezeEntityPosition(PlayerPedId(), true)

    CharacterData.SelectedCharIdentifier = nil
    CharacterData.SelectedCharIndex = 1

    FreezeEntityPosition(PlayerPedId(), false)

    if chars > 0 then

        local charData = CharacterData.Data[1]
        local charId   = tonumber(charData.charidentifier)

        CharacterData.SelectedCharIdentifier = charId 

        local gender = charData.gender == 0 and "mp_male" or "mp_female"

        if (charData and charData.skinComp == nil) then 
            print('it was null - throwing error')

            local cbdata = exports.tpz_core:ClientRpcCall().Callback.TriggerAwait("tpz_characters:getPlayerSkinInformation", { charId = charId } )
       
            if type(cbdata.skinComp) ~= "table" then
                cbdata.skinComp = json.encode(cbdata.skinComp)
            end
            
            charData.skinComp = cbdata.skinComp
        end

        LoadHashModel(joaat(gender))

        SetPlayerModel(gender)
        SetModelAsNoLongerNeeded(gender)

        LoadEntityComponents(PlayerPedId(), gender, charData.skinComp, true, false)

        local spawnCoords = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].SpawnPosition
        exports.tpz_core:getCoreAPI().TeleportToCoords(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.h)

        -- Request Coords Teleportation Collision
        if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
            RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
        end
    
        repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())

        ClearPedTasksImmediately(PlayerPedId(), true)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true)
        SetEntityInvincible(PlayerPedId(), true)

        Wait(1000)

        local scenarioStarted = false
        local playerCoords    = GetEntityCoords(PlayerPedId())

        if randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].PerformChairSeatScenario then

            local startTime = GetGameTimer()

            while not scenarioStarted and (GetGameTimer() - startTime) < 5000 do
                
                for _, object in ipairs(GetNearbyObjects(playerCoords)) do
            
                    local objectCoords = GetEntityCoords(object)
        
                    if #(playerCoords - objectCoords) <= 2.0 then
        
                        local chairpos = GetOffsetFromEntityInWorldCoords(object,0.0,-0.05,0.5)
                        local chairheading = GetEntityHeading(object)
        
                        TaskStartScenarioAtPosition(PlayerPedId(), joaat("GENERIC_SEAT_CHAIR_TABLE_SCENARIO"), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, -1, true, false)
        
                        Wait(250)
    
                        if IsPedUsingAnyScenario(PlayerPedId()) then
                            scenarioStarted = true
                            break
                        end
                    end
            
                end

                Wait(250)

            end

        else

            local sex            = charData.gender == 0 and "male" or "female"
            local scenarios      = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex]
            local randomScenario = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex][ math.random( #randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex]) ]
    
            TaskStartScenarioInPlace(PlayerPedId(), joaat(randomScenario), -1)
        end

        local account = json.decode(charData.accounts)

        if charData.played_time > 0 then 
            charData.played_time = convertSecondsToText(charData.played_time * 60)
        end

        SendNUIMessage({ action = 'set_selected_character_info', result = charData, cash = account['cash'], gold = account['gold']})

    end

    local newCameraCoords = randomPosition.CharacterPositions[1].Camera
    local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)

    SetCamActive(_cameraHandler, true)
    RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = newCameraCoords

    CameraHandler.z    = newCameraCoords.z
    CameraHandler.zoom = newCameraCoords.fov


    CharacterData.OnCharacterSelector = true

    if not REQUESTED_JOIN_DATA then 
        TriggerServerEvent('tpz_core:requestplayerJoiningData')
    end

    Wait(7000)
    LOADED_FIRST_CHAR = true 
    UpdateCharacterSelectorControls()

    Wait(3000)

	ToggleSelectionUI(true)

    if chars > 0 then 
        SendNUIMessage({ action = 'display_character_info'})
    end

    TriggerEvent("tpz_core:onCharacterSelection")

    DoScreenFadeIn(3000)


end)


function onSelectedCharacterLoad()
    ClearPedTasksImmediately(PlayerPedId(), true)
    
    local randomPosition = Config.OnCharacterSelector.Locations[CharacterData.PositionIndex]
    local charData = CharacterData.Data[CharacterData.SelectedCharIndex]
    local charId   = tonumber(charData.charidentifier)
    CharacterData.SelectedCharIdentifier = charId 

    local gender = charData.gender == 0 and "mp_male" or "mp_female"

    if (charData and charData.skinComp == nil) then 
        print('it was null - throwing error')

        local cbdata = exports.tpz_core:ClientRpcCall().Callback.TriggerAwait("tpz_characters:getPlayerSkinInformation", { charId = charId } )
   
        if type(cbdata.skinComp) ~= "table" then
            cbdata.skinComp = json.encode(cbdata.skinComp)
        end
        
        charData.skinComp = cbdata.skinComp
    end

    LoadHashModel(joaat(gender))

    SetPlayerModel(gender)
    SetModelAsNoLongerNeeded(gender)

    LoadEntityComponents(PlayerPedId(), gender, charData.skinComp, true, false)

    local spawnCoords = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].SpawnPosition
    exports.tpz_core:getCoreAPI().TeleportToCoords(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.h)

    -- Request Coords Teleportation Collision
    if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
        RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
    end

    repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())

    ClearPedTasksImmediately(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)

    local account = json.decode(charData.accounts)
    
    if charData.played_time > 0 then 
        charData.played_time = convertSecondsToText(charData.played_time * 60)
    end

    SendNUIMessage({ action = 'set_selected_character_info', result = charData, cash = account['cash'], gold = account['gold']})
    
    Wait(1000)

    local playerCoords = GetEntityCoords(PlayerPedId())

    if randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].PerformChairSeatScenario then

        for _, object in ipairs(GetNearbyObjects(playerCoords)) do
        
            local objectCoords = GetEntityCoords(object)

            if #(playerCoords - objectCoords) <= 2.0 then

                local chairpos = GetOffsetFromEntityInWorldCoords(object,0.0,-0.05,0.5)
                local chairheading = GetEntityHeading(object)

                TaskStartScenarioAtPosition(PlayerPedId(), joaat("GENERIC_SEAT_CHAIR_TABLE_SCENARIO"), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, -1, true, false)

                break
            end
    
        end

    else

        local sex            = charData.gender == 0 and "male" or "female"
        local scenarios      = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex]
        local randomScenario = randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex][ math.random( #randomPosition.CharacterPositions[CharacterData.SelectedCharIndex].Scenarios[sex]) ]

        TaskStartScenarioInPlace(PlayerPedId(), joaat(randomScenario), -1)
    end

    Wait(5000)
    
    DoScreenFadeIn(3000)

    CHARACTER_CHANGE_AWAIT = false
    ToggleSelectionUI(true)
    SendNUIMessage({ action = 'display_character_info'})

end

RegisterNetEvent('tpz_core:onPlayerFirstSpawn')
AddEventHandler("tpz_core:onPlayerFirstSpawn", function(coords, status, isdead, newChar, charIdentifier)
	
    local PlayerData = GetCharacterData()
		
    CharacterData.OnCharacterSelector    = false
    CharacterData.SelectedCharIdentifier = charIdentifier
end)

AddEventHandler("tpz_core:onCharacterSelection", function()

    Citizen.CreateThread(function()

        while CharacterData.OnCharacterSelector do

            Wait(0)
    
            if not CHARACTER_CHANGE_AWAIT then
    
                -- =========================================================
                -- PREVIOUS CHARACTER
                -- LEFT ARROW
                -- =========================================================
    
                if CheckControls(IsDisabledControlJustPressed, 0, 0xA65EBAB4) and CharacterData.Characters > 1 then
    
                    ToggleSelectionUI(false)

                    while not IsScreenFadedOut() do
                        Wait(50)
                        DoScreenFadeOut(2000)
                    end

                    CHARACTER_CHANGE_AWAIT = true 
    
                    DestroyAllCams(true)
    
                    CharacterData.SelectedCharIndex = CharacterData.SelectedCharIndex - 1
    
                    if CharacterData.SelectedCharIndex < 1 then
                        CharacterData.SelectedCharIndex = CharacterData.Characters
                    end
    
                    local newCameraCoords =
                        Config.OnCharacterSelector.Locations[
                            CharacterData.PositionIndex
                        ].CharacterPositions[
                            CharacterData.SelectedCharIndex
                        ].Camera
    
                    local _cameraHandler = CreateCamWithParams(
                        "DEFAULT_SCRIPTED_CAMERA",
                        newCameraCoords.x,
                        newCameraCoords.y,
                        newCameraCoords.z,
                        newCameraCoords.rotx,
                        newCameraCoords.roty,
                        newCameraCoords.rotz,
                        newCameraCoords.fov,
                        false,
                        2
                    )
    
                    SetCamActive(_cameraHandler, true)
    
                    RenderScriptCams(
                        true,
                        false,
                        0,
                        true,
                        true,
                        0
                    )
    
                    CameraHandler.coords = newCameraCoords
                    CameraHandler.z = newCameraCoords.z
                    CameraHandler.zoom = newCameraCoords.fov
    
                    onSelectedCharacterLoad()
    
                end
    
    
                -- =========================================================
                -- NEXT CHARACTER
                -- RIGHT ARROW
                -- =========================================================
    
                if CheckControls(IsDisabledControlJustPressed, 0, 0xDEB34313) and CharacterData.Characters > 1 then
    
                    ToggleSelectionUI(false)

                    while not IsScreenFadedOut() do
                        Wait(50)
                        DoScreenFadeOut(2000)
                    end

                    CHARACTER_CHANGE_AWAIT = true 
    
                    DestroyAllCams(true)
    
                    CharacterData.SelectedCharIndex = CharacterData.SelectedCharIndex + 1
    
                    if CharacterData.SelectedCharIndex > CharacterData.Characters then
                        CharacterData.SelectedCharIndex = 1
                    end
    
                    local newCameraCoords =
                        Config.OnCharacterSelector.Locations[
                            CharacterData.PositionIndex
                        ].CharacterPositions[
                            CharacterData.SelectedCharIndex
                        ].Camera
    
                    local _cameraHandler = CreateCamWithParams(
                        "DEFAULT_SCRIPTED_CAMERA",
                        newCameraCoords.x,
                        newCameraCoords.y,
                        newCameraCoords.z,
                        newCameraCoords.rotx,
                        newCameraCoords.roty,
                        newCameraCoords.rotz,
                        newCameraCoords.fov,
                        false,
                        2
                    )
    
                    SetCamActive(_cameraHandler, true)
    
                    RenderScriptCams(
                        true,
                        false,
                        0,
                        true,
                        true,
                        0
                    )
    
                    CameraHandler.coords = newCameraCoords
                    CameraHandler.z = newCameraCoords.z
                    CameraHandler.zoom = newCameraCoords.fov
    
                    onSelectedCharacterLoad()
    
                end
    
                -- =========================================================
                -- DELETE CHARACTER
                -- DELETE
                -- =========================================================

                if CheckControls(IsDisabledControlJustPressed, 0, 0x4AF4D473) then
   
                    CHARACTER_CHANGE_AWAIT = true 

                    
                    ToggleSelectionUI(false)

                    while not IsScreenFadedOut() do
                        Wait(50)
                        DoScreenFadeOut(2000)
                    end

                    TriggerServerEvent("tpz_characters:deleteSelectedCharacter", CharacterData.SelectedCharIdentifier )

                    UpdateCharacterSelectorControls()

                    
                    CharacterData.Data[CharacterData.SelectedCharIndex] = nil

                    CharacterData.Characters = CharacterData.Characters - 1

                    if CharacterData.Characters < 0 then 
                        CharacterData.Characters = 0
                    end

                    CharacterData.SelectedCharIdentifier = nil
                    CharacterData.SelectedCharIndex = 1
                    
                    DestroyAllCams(true)
    
                    local newCameraCoords =
                        Config.OnCharacterSelector.Locations[
                            CharacterData.PositionIndex
                        ].CharacterPositions[
                            CharacterData.SelectedCharIndex
                        ].Camera
    
                    local _cameraHandler = CreateCamWithParams(
                        "DEFAULT_SCRIPTED_CAMERA",
                        newCameraCoords.x,
                        newCameraCoords.y,
                        newCameraCoords.z,
                        newCameraCoords.rotx,
                        newCameraCoords.roty,
                        newCameraCoords.rotz,
                        newCameraCoords.fov,
                        false,
                        2
                    )
    
                    SetCamActive(_cameraHandler, true)
    
                    RenderScriptCams(
                        true,
                        false,
                        0,
                        true,
                        true,
                        0
                    )
    
                    CameraHandler.coords = newCameraCoords
                    CameraHandler.z = newCameraCoords.z
                    CameraHandler.zoom = newCameraCoords.fov

                    if CharacterData.Characters > 0 then 

                        onSelectedCharacterLoad()

                    else
                        CharacterData.OnCharacterSelector = false
    
                        Wait(250)
                        ToggleUI(true)

                        break
                    end
                end

                -- =========================================================
                -- SELECT CHARACTER
                -- ENTER
                -- =========================================================
    
                if CheckControls(IsDisabledControlJustPressed, 0, 0xC7B5340A) and CharacterData.Characters > 0 then
    
                    CharacterData.OnCharacterSelector = false
                    
                    ToggleSelectionUI(false)

                    while not IsScreenFadedOut() do
                        Wait(50)
                        DoScreenFadeOut(2000)
                    end

                    DestroyAllCams(true)
    
                    local charData =
                        CharacterData.Data[
                            CharacterData.SelectedCharIndex
                        ]
    
                    local charId =
                        tonumber(charData.charidentifier)
    
                    CharacterData.SelectedCharIdentifier = charId
    
                    ClearPedTasksImmediately(
                        PlayerPedId(),
                        true
                    )
    
                    NetworkClearClockTimeOverride()
    
                    exports.weathersync:setSyncEnabled(true)
    
                    TriggerServerEvent(
                        'tpz_core:instanceplayers',
                        0
                    )
    
                    TriggerServerEvent(
                        'tpz_core:onSelectedCharacter',
                        nil,
                        charId,
                        false
                    )
    
                    DisplayRadar(true)
    
                    ExecuteCommand("hud:hideall")
    
                    Citizen.InvokeNative(
                        0x706D57B0F50DA710,
                        "MC_MUSIC_STOP"
                    )
    
                    FreezeEntityPosition(
                        PlayerPedId(),
                        false
                    )
    
                    SetEntityVisible(
                        PlayerPedId(),
                        true
                    )
    
                    SetEntityInvincible(
                        PlayerPedId(),
                        false
                    )
    
                    SetEntityCanBeDamaged(
                        PlayerPedId(),
                        true
                    )
    
                    CharacterData.IsBusy = false
    
                    break
    
                end
    
    
                -- =========================================================
                -- CREATE CHARACTER
                -- SPACE
                -- =========================================================
    
                if CheckControls(IsDisabledControlJustPressed, 0, 0xD9D0E1C0) then
    
                    if CharacterData.Characters < CharacterData.MaxCharacters then
                        ToggleSelectionUI(false)
                        CharacterData.OnCharacterSelector = false
    
                        Wait(250)
                        ToggleUI(true)
    
                        break
                    end
    
                end

            end
    
        end

    end)

end)
