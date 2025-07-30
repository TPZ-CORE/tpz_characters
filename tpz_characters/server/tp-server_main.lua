local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterServerEvent("tpz_characters:deleteSelectedCharacter")
AddEventHandler("tpz_characters:deleteSelectedCharacter", function(charId)
	local _source = source

	if (_source == nil) or (_source and GetSteamID(_source) == nil) then
		return
	end

	local steamId = GetSteamID(_source)

    exports["ghmattimysql"]:execute("SELECT * FROM `characters` WHERE `charidentifier` = @charidentifier", { ['charidentifier'] = tonumber(charId) }, function(result)

		if result == nil or result[1] == nil then
			return
		end

		local res = result[1]

		-- The only way deleting a character with the specified event, is only through characters creation.
		-- In case the identifier is not the same identifier on the selected character that must be deleted,
		-- it is a devtools / injection cheat.
		if res.identifier ~= tostring(steamId) then
			print(string.format('[WARNING] - [DevTools / Injection FOUND] The player with the online id: %s and Steam Identifier: %s attempted to delete a character of another player.', _source, tostring(steamId)))
			
			local steamName = GetPlayerName(_source)

			if Config.Webhooks['DEVTOOLS_INJECTION_CHEAT'].Enabled then
      local _w, _c      = Config.Webhooks['DEVTOOLS_INJECTION_CHEAT'].Url, Config.Webhooks['DEVTOOLS_INJECTION_CHEAT'].Color
      local description = 'The specified user attempted to use devtools / injection in attempt to delete a character of another player.'
      TPZ.SendToDiscordWithPlayerParameters(_w, Locales['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG'], _source, steamName, "n/a", tostring(steamId), "n/a", description, _c)
   end

			if TPZ.GetPlayer(_source).loaded() then
	   TPZ.GetPlayer(_source).ban(Locales['DEVTOOLS_INJECTION_DETECTED'], -1)
			end

			return
		end

		exports.ghmattimysql:execute("DELETE FROM `characters` WHERE `charidentifier` = @charidentifier", {["@charidentifier"] = tonumber(charId) })
		-- delete success

	end)

end)

-- @added by dobiban
RegisterServerEvent("tpz_characters:requestCharacterSkin")
AddEventHandler("tpz_characters:requestCharacterSkin", function(targetSource)
	local _source = source

	if targetSource then
		_source = tonumber(targetSource)
	end

	local xPlayer = TPZ.GetPlayer(_source)

	if not xPlayer.loaded() then print("Character not selected or loaded.") return end 

	local identifier = xPlayer.getIdentifier()
	local charIdentifier = xPlayer.getCharacterIdentifier()
    
    exports["ghmattimysql"]:execute("SELECT * FROM characters WHERE charidentifier = @charidentifier", { ['charidentifier'] = charIdentifier}, function(result)
        if result and result[1] then
            local charData = result[1]
            TriggerClientEvent('tpz_characters:receiveSkinData', _source, {
                skin = charData.skin,
                skinComp = charData.skinComp,
                gender = charData.gender
            })
        else
            print(string.format("[TPZ-CHARACTERS] Character {%s} not found for %s", charIdentifier, identifier))
        end
    end)

end)

-----------------------------------------------------------
--[[ Callbacks ]]--
-----------------------------------------------------------

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_characters:getPlayerSkinInformation", function(source, cb, data)
    
    exports["ghmattimysql"]:execute("SELECT * FROM characters WHERE charidentifier = @charidentifier", { ['charidentifier'] = tonumber(data.charId)}, function(result)
        if result and result[1] then

            return cb({ 
                skin = result[1].skin, 
                skinComp = result[1].skinComp, 
                gender = result[1].gender 
            })
        else
            print('[TPZ-CHARACTERS] Character not found for charId:', data.charId)
            return cb(nil)
        end
    end)
end)

