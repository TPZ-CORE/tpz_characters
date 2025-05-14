
-----------------------------------------------------------
--[[ Exports  ]]--
-----------------------------------------------------------

-- returns the MP configuration file with all the required data to be used.
exports('getMPConfiguration', function()
	return MP
end)

-- returns the ClothHashNames file with all the required data to be used.
exports('getClothHashNamesList', function()
	return ClothHashNames
end)

exports('toggleOverlayChange', function(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk,
	palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var,
	opacity, albedo)

	toggleOverlayChange(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk,
	palette_id, palette_color_primary, palette_color_secondary, palette_color_tertiary, var,
	opacity, albedo)
end)