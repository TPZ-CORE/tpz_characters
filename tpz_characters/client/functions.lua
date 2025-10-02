
-----------------------------------------------------------
--[[ Prompts  ]]--
-----------------------------------------------------------

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

    Citizen.InvokeNative(0x00EDE88D4D13CF59, SelectorPrompts) -- UiPromptDelete
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
	DestroyAllCams(true)

    local cameraHandler = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z, rotx, roty, rotz, fov, false, 2)
    
	SetCamActive(cameraHandler, true)

	RenderScriptCams(true, true, 500, true, true)

end
