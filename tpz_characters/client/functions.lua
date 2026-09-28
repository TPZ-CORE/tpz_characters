
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
        RemoveImap(183712523)
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
	DestroyAllCams(true)

    local cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, rotx, roty, rotz, fov, false, 2)
    
	SetCamActive(cameraHandler, true)

	RenderScriptCams(true, true, 500, true, true)

end

function convertSecondsToText(seconds)
    local secondsInMinute = 60
    local secondsInHour   = 60 * secondsInMinute
    local secondsInDay    = 24 * secondsInHour
    local secondsInMonth  = 30 * secondsInDay  -- Assuming 30-day months

    local months          = math.floor(seconds / secondsInMonth)
    local days            = math.floor((seconds % secondsInMonth) / secondsInDay)
    local hours           = math.floor((seconds % secondsInDay) / secondsInHour)
    local mins            = math.floor((seconds % secondsInHour) / secondsInMinute)

    local parts = {}

    if months > 0 then
        table.insert(parts, months .. " " .. (months ~= 1 and Locales['MONTHS'] or Locales['MONTH']))
    end

    if days > 0 then
        table.insert(parts, days .. " " .. (days ~= 1 and Locales['DAYS'] or Locales['DAY']))
    end

    if hours > 0 then
        table.insert(parts, hours .. " " .. (hours ~= 1 and Locales['HOURS'] or Locales['HOUR']))
    end

    if mins > 0 then
        table.insert(parts, mins .. " " .. (mins ~= 1 and Locales['MINUTES'] or Locales['MINUTE']))
    end

	if seconds < 60 then
		table.insert(parts, seconds .. " " .. (seconds ~= 1 and Locales['SECONDS'] or Locales['SECOND']))
	end

    return table.concat(parts, " " .. Locales['AND'] .. " ")
end
