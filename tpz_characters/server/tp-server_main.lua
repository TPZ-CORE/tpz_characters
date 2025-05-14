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
			return
		end

		exports.ghmattimysql:execute("DELETE FROM `characters` WHERE `charidentifier` = @charidentifier", {["@charidentifier"] = tonumber(charId) })
		-- delete success

	end)

end)

-----------------------------------------------------------
--[[ Callbacks ]]--
-----------------------------------------------------------

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_characters:getPlayerSkinInformation", function(source, cb, data)

    exports["ghmattimysql"]:execute("SELECT * FROM characters WHERE charidentifier = @charidentifier", { ['charidentifier'] = tonumber(data.charId) }, function(result)

		while result == nil or result[1] == nil do
			Wait(100)
		end

        return { skin = result[1].skin, skinComp = result[1].skinComp, gender = result[1].gender }
    end)

end)
