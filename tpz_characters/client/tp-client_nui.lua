RegisterData = {firstname = nil, lastname = nil, dob = nil, gender = nil, job = nil}

-----------------------------------------------------------
--[[ Functions  ]]--
-----------------------------------------------------------

function SetNUIStatus(state)

    SetNuiFocus(state, state)
	SendNUIMessage({ type = "enableui", enable = state })
end

-----------------------------------------------------------
--[[ NUI Callbacks  ]]--
-----------------------------------------------------------

RegisterNUICallback('submit', function(data)

    local isInputNameAllowed   = true
    local isDateOfBirthValid   = true

    local blacklistedNamesList = Config.BlacklistedNames
    
    for index, name in pairs (blacklistedNamesList) do

        if data.firstname == name or data.lastname == name then
            isInputNameAllowed = false
        end
    end

    if data.dateofbirth == "invalid" then
        isDateOfBirthValid = false
    end

    if isDateOfBirthValid and isInputNameAllowed then

        RegisterData.firstname = data.firstname
        RegisterData.lastname  = data.lastname
        RegisterData.dob       = data.dateofbirth
        RegisterData.gender    = tonumber(data.sex)
        RegisterData.job       = data.job
            
        SetNUIStatus(false)

        CreateCharacterLobbyHandlers(tonumber(data.sex))

        -- [[ We open the character customization menu & control actions ]] 
        OpenCharacterCustomization()
        StartMenuControlActions()

    else
        -- @isDateOfBirthValid || @isInputNameAllowed == false.
    end

end)

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)

    Wait(2000)
    SetNUIStatus(false)

    GetCharacterData().OnCharacterSelector = true
end)