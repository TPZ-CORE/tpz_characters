
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
        CharacterData.MaxCharacters = exports.tpz_core:getCoreAPI().GetConfig().MaxCharacters
    else
        CharacterData.MaxCharacters = userData.max_chars
    end

    if Config.Debug then
        print(string.format("Maximum Characters Limit: %s", CharacterData.MaxCharacters))
    end

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

    CharacterData.IsBusy     = true 
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

    local spawnCoords = randomPosition.CharacterPositions[1].SpawnPosition
    exports.tpz_core:getCoreAPI().TeleportToCoords(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.h)

    -- Request Coords Teleportation Collision
    if not HasCollisionLoadedAroundEntity(PlayerPedId()) then
        RequestCollisionAtCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z)
    end

    repeat Wait(0) until HasCollisionLoadedAroundEntity(PlayerPedId())

    ExecuteCommand('hud:hideall')

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

    end

    local newCameraCoords = randomPosition.CharacterPositions[1].Camera
    local _cameraHandler  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", newCameraCoords.x, newCameraCoords.y, newCameraCoords.z, newCameraCoords.rotx, newCameraCoords.roty, newCameraCoords.rotz, newCameraCoords.fov, false, 2)

    SetCamActive(_cameraHandler, true)
    RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = newCameraCoords

    CameraHandler.z    = newCameraCoords.z
    CameraHandler.zoom = newCameraCoords.fov


    CharacterData.OnCharacterSelector = true

    Wait(4000)
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

    Wait(4000)
    DoScreenFadeIn(3000)

end

/*
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

            local gender = data[index].gender == 0 and "mp_male" or "mp_female"

            LoadHashModel(joaat(gender))
    
            local charSpawnCoords = randomPosition.CharacterPositions[index].SpawnPosition
            local entity          = CreatePed(joaat(gender), charSpawnCoords.x, charSpawnCoords.y, charSpawnCoords.z, charSpawnCoords.h, false, false, false, false)
            
            repeat Wait(0) until DoesEntityExist(entity)

            Wait(1000)

            LoadEntityComponents(entity, gender, data[index].skinComp, false, false)

            SetAttributeCoreValue(entity, 1, 100) --_SET_ATTRIBUTE_CORE_VALUE
            SetAttributeCoreValue(entity, 0, 100)
    
            data[index].entity = entity 

            local sex            = data[index].gender == 0 and "male" or "female"
            local scenarios      = randomPosition.CharacterPositions[index].Scenarios[sex]
            local randomScenario = randomPosition.CharacterPositions[index].Scenarios[sex][ math.random( #randomPosition.CharacterPositions[index].Scenarios[sex]) ]
    
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
end)*/

RegisterNetEvent('tpz_core:onPlayerFirstSpawn')
AddEventHandler("tpz_core:onPlayerFirstSpawn", function(coords, status, isdead, newChar, charIdentifier)
	
    local PlayerData = GetCharacterData()
		
    PlayerData.OnCharacterSelector    = false
    PlayerData.SelectedCharIdentifier = charIdentifier
end)

-----------------------------------------------------------
--[[ Threads ]]--
-----------------------------------------------------------

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
                PromptSetEnabled(prompt.prompt, 0)
                
                if prompt.type == 'CREATE_CHARACTER' then

                    PromptSetEnabled(prompt.prompt, 0)

                    if CharacterData.Characters < CharacterData.MaxCharacters then
                        PromptSetVisible(prompt.prompt, 1)
                        PromptSetEnabled(prompt.prompt, 1)
                    end

                end

                if CharacterData.Characters > 0 and prompt.type ~= 'CREATE_CHARACTER' then

                    if prompt.type == 'NEXT_CHARACTER' or prompt.type == 'PREVIOUS_CHARACTER' then
                        local enabled = CharacterData.Characters == 1 and 0 or 1
                        PromptSetEnabled(prompt.prompt, enabled)
                    end

                    if prompt.type == "SELECT_CHARACTER" then
                        PromptSetEnabled(prompt.prompt, 1)
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

                        onSelectedCharacterLoad()

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

                        onSelectedCharacterLoad()
                    

                    elseif prompt.type == 'SELECT_CHARACTER' then

                        CharacterData.OnCharacterSelector = false
    
                        while not IsScreenFadedOut() do
                            Wait(50)
                            DoScreenFadeOut(2000)
                        end

                        DestroyAllCams(true)

                        local charData = CharacterData.Data[CharacterData.SelectedCharIndex]
                        local charId   = tonumber(charData.charidentifier)

                        CharacterData.SelectedCharIdentifier = charId 

                        ClearPedTasksImmediately(PlayerPedId(), true)
                
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

                        ToggleUI(true)

            

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
