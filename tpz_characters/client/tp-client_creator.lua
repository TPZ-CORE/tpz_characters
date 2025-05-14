SkinData = {}

CurrentCharCreateCoords = nil

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end

    TriggerServerEvent('tpz_core:instanceplayers', 0) -- Removing all the instanced players after selecting a character.

    if SkinData['entity_model'] then
        DeleteEntity(SkinData['entity_model'])
        DeletePed(SkinData['entity_model'])
        SetEntityAsNoLongerNeeded(SkinData['entity_model'])
    end

    MenuData.CloseAll()

    DestroyAllCams(true)

    DoScreenFadeIn(100)
    TaskStandStill(PlayerPedId(), 1)

	Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")
end)

-----------------------------------------------------------
--[[ Events  ]]--
-----------------------------------------------------------


function CreateCharacterLobbyHandlers(sex)
    
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
    exports.tpz_core.getCoreAPI().teleportToCoords(createCharCoords.x, createCharCoords.y, createCharCoords.z, createCharCoords.h)

    -- [[ Creating camera handlers on character create (random selected coords) ]]
    local cameraCoords = CreatorData.Modifications.MainCamera
    local _cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cameraCoords.x, cameraCoords.y, cameraCoords.z, cameraCoords.rotx, cameraCoords.roty, cameraCoords.rotz, cameraCoords.fov, false, 2)

	SetCamActive(_cameraHandler, true)
	RenderScriptCams(true, false, 0, true, true, 0)

    CameraHandler.coords = cameraCoords
    CameraHandler.z      = cameraCoords.z
    CameraHandler.zoom   = cameraCoords.fov

    -- [[ Creating all player skin required data ]]
    SkinData['sex']    = 0
    SkinData['model']  = "mp_male"
	SkinData['albedo'] = GetHashKey("mp_head_mr1_sc08_c0_000_ab")

    if tonumber(sex) == 1 then
        SkinData['sex']    = 1
        SkinData['model']  = "mp_female"
        SkinData['albedo'] = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
    end

    SkinData['ageing_tx_id']      = -1
    SkinData['ageing_opacity']    = 0
    SkinData['ageing_visibility'] = 0

    LoadModel(SkinData['model'])

    SetPlayerModel(SkinData['model'])
    DefaultPedSetup(PlayerPedId())

    CurrentCharCreateCoords = createCharCoords.Coords

    Wait(5000)
    
    DoScreenFadeIn(2000)
end

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

function DefaultPedSetup(ped)

    local sex      = "male"
    local finished = false

    if SkinData['sex'] == 1 then
        sex = "female"
    end

	if sex == "male" then
		Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 0, 0)

    elseif sex == "female" then
		Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 7, true)
	end

	Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
	Citizen.InvokeNative(0x77FF8D35EEC6BBC4, ped, 3, 0) -- outfits

    UpdateVariation(ped)
	IsPedReadyToRender(ped)

    for customization, hash in pairs (MP.DefaultCustomization[sex]) do
        ApplyComponentToPed(ped, hash)
    end

end

-----------------------------------------------------------
--[[ Camera Functions & Thread Looping Function ]]--
-----------------------------------------------------------

local heading = 0

local function AdjustEntityPedHeading(amount)
	heading = heading + amount
	SetPedDesiredHeading(PlayerPedId(), heading)
end

-- The following function gets activated only after selecting a sex (gender).
-- What does this system do, is displaying the prompt keys and labels even that we are not going to use them, and use Control Press instead.
-- The prompt displaying is just for displaying, otherwise we have to loop through every key for every action.
function StartMenuControlActions()

    CreateCharacterPrompts()

    heading = GetEntityHeading(PlayerPedId())
    Wait(1000)

    Citizen.CreateThread(function()

        while IsPlayInCharMenu do
            Citizen.Wait(0)

            DisableControlAction(0, 0xB238FE0B, true) -- TAB
            DisableControlAction(0, 0xAC4BD4F1, true) -- TAB HOLD
    
            local playerPed = PlayerPedId()

            -- Displaying prompt label and keys.
            local label = CreateVarString(10, 'LITERAL_STRING', Config.OnCharacterCreate.CameraAdjustmentPromptDescription)
            PromptSetActiveGroupThisFrame(Prompts, label)
    
            -- Pressed right key.
            if IsControlPressed(2, 0x7065027D) then
                AdjustEntityPedHeading(-5.0)
            end
    
            -- Pressed left key.
            if IsControlPressed(2, 0xB4E465B4) then
                AdjustEntityPedHeading(5.0)
            end

            -- UP CAMERA
            if IsControlPressed(2, 0x8FD015D8) then
                CameraHandler.z = CameraHandler.coords.z

                StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
                CameraHandler.coords.rotz, CameraHandler.zoom)

            end

            -- DOWN CAMERA
            if IsControlPressed(2, 0xD27782E3) then
                CameraHandler.z = CameraHandler.coords.z - 1.0

                StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.coords.z - 1.0, CameraHandler.coords.rotx, CameraHandler.coords.roty,
                CameraHandler.coords.rotz, CameraHandler.zoom)

            end

            if IsControlPressed(2, 0x8BDE7443) then -- zoom out

                if CameraHandler.zoom < 104.0 then -- Zoom out limit

                    CameraHandler.zoom = CameraHandler.zoom + 4.0

                    StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
                    CameraHandler.coords.rotz, CameraHandler.zoom)
                end
            end

            if IsControlPressed(2, 0x62800C92) then -- zoom in

                if CameraHandler.zoom > 8.0 then -- Zoom in limit
                    

                    CameraHandler.zoom = CameraHandler.zoom - 4.0

                    StartCam(CameraHandler.coords.x, CameraHandler.coords.y, CameraHandler.z, CameraHandler.coords.rotx, CameraHandler.coords.roty,
                    CameraHandler.coords.rotz, CameraHandler.zoom)
                end

            end

            -- Pressed X key.
            if IsControlPressed(2, 0x8CC9CD42) then

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

        end
    
    end)

end
