
local CharacterData = {
    PositionIndex       = 0,

    Characters          = 0,
    MaxCharacters       = 3,

    OnCharacterSelector = false,

    IsBusy              = true, -- for radar.

    SelectedCharIndex   = 0,
    Data                = {},
}

CameraHandler = {coords = nil, zoom = 0, z = 0 }

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

function DeleteCharacterEntities()

    for index, char in pairs (CharacterData.Data) do

        if char.entity then

            DeleteEntity(char.entity)
            DeletePed(char.entity)
            SetEntityAsNoLongerNeeded( char.entity )

        end

    end

end

function GetCharacterData()
    return CharacterData
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    DeleteCharacterEntities()
end)

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

-- on player join
RegisterNetEvent('tpz_core:playerJoining')
AddEventHandler("tpz_core:playerJoining", function(userData)

    if userData == nil or userData.max_chars == nil then
        CharacterData.MaxCharacters = Config.MaxCharacters
    else
        CharacterData.MaxCharacters = userData.max_chars
    end

    TriggerServerEvent('tpz_core:onPlayerJoined')
end)

RegisterNetEvent('tpz_characters:loadPlayerSkinComps')
AddEventHandler("tpz_characters:loadPlayerSkinComps", function()
    -- to-do
end)

-- Load character selection
RegisterNetEvent('tpz_characters:loadCharacterSelection')
AddEventHandler('tpz_characters:loadCharacterSelection', function(chars, data)
    Wait(1000)

    CharacterData.Characters = chars
    CharacterData.Data       = data

   -- local instanced = GetPlayerServerId(PlayerId()) + 456565
	--TriggerServerEvent('tpz_core:instanceplayers', math.floor(instanced)) 

    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(1000)
    end

    local randomPosition = Config.OnCharacterSelector.Locations[ math.random( #Config.OnCharacterSelector.Locations ) ]

    CharacterData.PositionIndex = randomPosition.Index

    ExecuteCommand('hud:hideall')

    exports.weathersync:setSyncEnabled(false)
	exports.weathersync:setMyWeather(randomPosition.Modifications.Weather.Type, randomPosition.Modifications.Weather.Transition,  randomPosition.Modifications.Weather.Snow)
	exports.weathersync:setMyTime(randomPosition.Modifications.ClockTime.Hour, 0, 0, randomPosition.Modifications.ClockTime.Transition, true)

    SetTimecycleModifier(randomPosition.Modifications.Timecycle.ModifierName)
	Citizen.InvokeNative(0xFDB74C9CC54C3F37, randomPosition.Modifications.Timecycle.Strength)

    local spawnCoords = randomPosition.Modifications.SpawnPlayerPosition
    exports.tpz_core.getCoreAPI().teleportToCoords(spawnCoords.x, spawnCoords.y, spawnCoords.z, 0)

    -- Request Music
    PrepareMusicEvent(randomPosition.Modifications.Music)
	Wait(100)
	TriggerMusicEvent(randomPosition.Modifications.Music)
	Wait(1000)

    -- Request Coords Teleportation Collision
	if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
		RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
	end

	repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())

    -- Modify Player Attributes
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityVisible(PlayerPedId(), false)
	SetEntityInvincible(PlayerPedId(), true)

    local cameraCoords   = randomPosition.Modifications.MainCamera
    local _cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cameraCoords.x, cameraCoords.y, cameraCoords.z, cameraCoords.rotx, cameraCoords.roty, cameraCoords.rotz, cameraCoords.fov, false, 2)

	SetCamActive(_cameraHandler, true)
	RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = cameraCoords

    CameraHandler.z    = cameraCoords.z
    CameraHandler.zoom = cameraCoords.fov

    if chars > 0 then

        for index = 1, chars do

            LoadHashModel(joaat(data[index].skin))
    
            local charSpawnCoords = randomPosition.CharacterPositions[index].SpawnPosition
            local entity          = CreatePed(joaat(data[index].skin), charSpawnCoords.x, charSpawnCoords.y, charSpawnCoords.z, charSpawnCoords.h, false, false, false, false)
            
            repeat Wait(0) until DoesEntityExist(entity)

            Wait(1000)

            LoadEntitySkinComps(entity, data[index].skinComp, tonumber(data[index].gender))
            SetEntityInvincible(entity, true)

            SetAttributeCoreValue(entity, 1, 100) --_SET_ATTRIBUTE_CORE_VALUE
            SetAttributeCoreValue(entity, 0, 100)
    
            data[index].entity = entity 
    
            local sex            = GetGenderByInteger(tonumber(data[index].gender))
            local scenarios      = randomPosition.CharacterPositions[index].Scenarios[sex]
            local randomScenario = randomPosition.CharacterPositions[index].Scenarios[sex][ math.random( #randomPosition.CharacterPositions[1].Scenarios[sex]) ]
    
            TaskStartScenarioInPlace(entity, joaat(randomScenario), -1)
            SetPedCanBeTargetted(entity, false)

            Wait(1000)

        end

    end

    DoScreenFadeIn(1000)

    if chars > 0 then
        
        Wait(5000)

        while not IsScreenFadedOut() do
            Wait(50)
            DoScreenFadeOut(2000)
        end
    
        DestroyAllCams(true)

        local newCameraCoords = randomPosition.CharacterPositions[1].Camera
        local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)
    
        SetCamActive(_cameraHandler, true)
        RenderScriptCams(true, false, 0, true, true, 0)
    
        CameraHandler.coords = newCameraCoords
    
        CameraHandler.z    = newCameraCoords.z
        CameraHandler.zoom = newCameraCoords.fov

        DoScreenFadeIn(3000)

        CharacterData.SelectedCharIndex = 1
    end

    CharacterData.OnCharacterSelector = true
end)



RegisterNetEvent('tpz_characters:refreshCharacterSelection')
AddEventHandler('tpz_characters:refreshCharacterSelection', function(chars, data)

    while not IsScreenFadedOut() do
        Wait(50)
        DoScreenFadeOut(2000)
    end

    DestroyAllCams(true)
    DeleteCharacterEntities()

    CharacterData.SelectedCharIndex = 0

    CharacterData.Characters = chars
    CharacterData.Data       = data

    local randomPosition     = Config.OnCharacterSelector.Locations[CharacterData.PositionIndex]

    local cameraCoords       = randomPosition.Modifications.MainCamera
    local _cameraHandler     = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cameraCoords.x, cameraCoords.y, cameraCoords.z, cameraCoords.rotx, cameraCoords.roty, cameraCoords.rotz, cameraCoords.fov, false, 2)

	SetCamActive(_cameraHandler, true)
	RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = cameraCoords

    CameraHandler.z    = cameraCoords.z
    CameraHandler.zoom = cameraCoords.fov

    if chars > 0 then

        for index = 1, chars do

            LoadHashModel(joaat(data[index].skin))
    
            local charSpawnCoords = randomPosition.CharacterPositions[index].SpawnPosition
            local entity          = CreatePed(joaat(data[index].skin), charSpawnCoords.x, charSpawnCoords.y, charSpawnCoords.z, charSpawnCoords.h, false, false, false, false)
            
            repeat Wait(0) until DoesEntityExist(entity)

            Wait(1000)

            LoadEntitySkinComps(entity, data[index].skinComp, tonumber(data[index].gender))
            SetEntityInvincible(entity, true)

            SetAttributeCoreValue(entity, 1, 100) --_SET_ATTRIBUTE_CORE_VALUE
            SetAttributeCoreValue(entity, 0, 100)
    
            data[index].entity = entity 
    
            local sex            = GetGenderByInteger(tonumber(data[index].gender))
            local scenarios      = randomPosition.CharacterPositions[index].Scenarios[sex]
            local randomScenario = randomPosition.CharacterPositions[index].Scenarios[sex][ math.random( #randomPosition.CharacterPositions[1].Scenarios[sex]) ]
    
            TaskStartScenarioInPlace(entity, joaat(randomScenario), -1)
            SetPedCanBeTargetted(entity, false)

            Wait(1000)

        end

    end

    DoScreenFadeIn(1000)

    if chars > 0 then
        
        Wait(5000)

        while not IsScreenFadedOut() do
            Wait(50)
            DoScreenFadeOut(2000)
        end
    
        DestroyAllCams(true)

        local newCameraCoords = randomPosition.CharacterPositions[1].Camera
        local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)
    
        SetCamActive(_cameraHandler, true)
        RenderScriptCams(true, false, 0, true, true, 0)
    
        CameraHandler.coords = newCameraCoords
    
        CameraHandler.z    = newCameraCoords.z
        CameraHandler.zoom = newCameraCoords.fov

        DoScreenFadeIn(3000)

        CharacterData.SelectedCharIndex = 1
    end

    CharacterData.OnCharacterSelector = true
end)

-----------------------------------------------------------
--[[ Threads ]]--
-----------------------------------------------------------

Citizen.CreateThread(function()

    while true do

        Wait(0)
        
        if CharacterData.IsBusy then
            DisplayRadar(false)
            
        else
            Wait(1000)
        end

    end

end)

-- Reload Skin Cooldown timer for removing.
Citizen.CreateThread(function()

    RegisterCharacterSelectorPrompts()

    while true do

        Wait(0)

        if CharacterData.OnCharacterSelector then

            local promptGroup, promptList = GetSelectorPromptData()

            local characterUsername = ""

            if CharacterData.SelectedCharIndex ~= 0 then
                characterUsername = CharacterData.Data[CharacterData.SelectedCharIndex].firstname .. ' ' .. CharacterData.Data[CharacterData.SelectedCharIndex].lastname
            end

            local label = CreateVarString(10, 'LITERAL_STRING', characterUsername)
            PromptSetActiveGroupThisFrame(promptGroup, label)

            for i, prompt in pairs (promptList) do
                PromptSetVisible(prompt.prompt, 0)

                if CharacterData.Characters < CharacterData.MaxCharacters and prompt.type == 'CREATE_CHARACTER' then
                    PromptSetVisible(prompt.prompt, 1)
                end

                if CharacterData.Characters > 0 and prompt.type ~= 'CREATE_CHARACTER' then

                    if prompt.type == 'NEXT_CHARACTER' or prompt.type == 'PREVIOUS_CHARACTER' then
                        local enabled = CharacterData.Characters == 1 and 0 or 1
                        PromptSetEnabled(prompt.prompt, enabled)
                    end

                    PromptSetVisible(prompt.prompt, 1)
                end

                if PromptHasHoldModeCompleted(prompt.prompt) then

                    if prompt.type == 'NEXT_CHARACTER' then

                        while not IsScreenFadedOut() do
                            Wait(50)
                            DoScreenFadeOut(2000)
                        end

                        DestroyAllCams(true)

                        CharacterData.SelectedCharIndex = CharacterData.SelectedCharIndex + 1

                        if CharacterData.SelectedCharIndex > CharacterData.Characters then
                            CharacterData.SelectedCharIndex = 1
                        end
                    
                        local newCameraCoords = Config.OnCharacterSelector.Locations[CharacterData.PositionIndex].CharacterPositions[CharacterData.SelectedCharIndex].Camera
                        local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)
                    
                        SetCamActive(_cameraHandler, true)
                        RenderScriptCams(true, false, 0, true, true, 0)
                    
                        CameraHandler.coords = newCameraCoords
                    
                        CameraHandler.z    = newCameraCoords.z
                        CameraHandler.zoom = newCameraCoords.fov
                    
                        DoScreenFadeIn(3000)

                        Wait(1000)

                    elseif prompt.type == 'PREVIOUS_CHARACTER' then

                        while not IsScreenFadedOut() do
                            Wait(50)
                            DoScreenFadeOut(2000)
                        end

                        DestroyAllCams(true)
                    
                        CharacterData.SelectedCharIndex = CharacterData.SelectedCharIndex - 1

                        if CharacterData.SelectedCharIndex < 1 then
                            CharacterData.SelectedCharIndex = CharacterData.Characters
                        end

                        local newCameraCoords = Config.OnCharacterSelector.Locations[CharacterData.PositionIndex].CharacterPositions[CharacterData.SelectedCharIndex].Camera
                        local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)
                    
                        SetCamActive(_cameraHandler, true)
                        RenderScriptCams(true, false, 0, true, true, 0)
                    
                        CameraHandler.coords = newCameraCoords
                    
                        CameraHandler.z    = newCameraCoords.z
                        CameraHandler.zoom = newCameraCoords.fov
                    
                        DoScreenFadeIn(3000)

                        Wait(1000)

                    elseif prompt.type == 'SELECT_CHARACTER' then

                        CharacterData.OnCharacterSelector = false
    
                        while not IsScreenFadedOut() do
                            Wait(50)
                            DoScreenFadeOut(2000)
                        end

                        DestroyAllCams(true)

                        local charData = CharacterData.Data[CharacterData.SelectedCharIndex]
                        local charId   = tonumber(charData.charidentifier)

                        ClearPedTasksImmediately(PlayerPedId(), true)
                
                        LoadHashModel(joaat(charData.skin))

                        Wait(1000)

                        SetPlayerModel(charData.skin)
                        SetModelAsNoLongerNeeded(charData.skin)

                        Wait(1000)

                        LoadEntitySkinComps(PlayerPedId(), charData.skinComp, tonumber(charData.gender))
                        
                        NetworkClearClockTimeOverride()
                        exports.weathersync:setSyncEnabled(true)

                       -- TriggerServerEvent('tpz_core:instanceplayers', 0) -- Removing all the instanced players after selecting a character.
                        TriggerServerEvent('tpz_core:onSelectedCharacter', nil, charId, false)
                        DisplayRadar(true)
                        ExecuteCommand("hud:hideall")

                        Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
            
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true)
                        SetEntityInvincible(PlayerPedId(), false)
                        SetEntityCanBeDamaged(PlayerPedId(), true)

                        DeleteCharacterEntities()
                        ClearSelectorPrompt()

                        CharacterData.IsBusy = false
                        
                        break

                    elseif prompt.type == 'CREATE_CHARACTER' then

                        CharacterData.OnCharacterSelector = false
                        SetNUIStatus(true)

                    elseif prompt.type == 'DELETE_CHARACTER' then

                        CharacterData.OnCharacterSelector = false

                        local charData = CharacterData.Data[CharacterData.SelectedCharIndex]
                        local charId   = tonumber(charData.charidentifier)

                        TriggerServerEvent("tpz_characters:deleteSelectedCharacter", charId )

                        Wait(1000)
                        TriggerServerEvent("tpz_core:requestCharacters", true)

                    end


                    Wait(10)
                end

            end

        else
            Wait(1000)
        end

    end

end)


-----------------------------------------------------------
--[[ Commands ]]--
-----------------------------------------------------------

-- Reload Character Command (if set to true).
if Config.ReloadCharacterCommand then

    RegisterCommand(Config.ReloadCharacterCommandExecute, function()

        if reloadSkinCooldown <= 0 then

            reloadSkinCooldown = Config.ReloadCharacterCommandExecuteCooldown

            TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_characters:getPlayerSkinInformation", function(data)

                SetPlayerModel(data.skin)
                LoadEntitySkinComps(PlayerPedId(), data.skinComp, data.gender)

            end, {charId = SelectedCharIdentifier} )

        else
            TriggerEvent('tpz_core:sendNotification', string.format(Locales['RELOAD_CHARACTER_COMMAND_COOLDOWN'], reloadSkinCooldown), "right")
        end

    end)

end