
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

            local data = exports.tpz_core:getCoreAPI().GetPlayerClientData()

            reloadSkinCooldown = Config.ReloadCharacter.Cooldown

            local gender = data.gender == 0 and "mp_male" or "mp_female"
            LoadEntityComponents(PlayerPedId(), gender, data.skinComp, true, true)

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


