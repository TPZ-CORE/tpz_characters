
-- @Credits to KadDarem, taken from jo_libs. 

local Components = {}

---------------------------------------
-- Functions
----------------------------------------

--- A function to format component data
---@param _data string|number|table (The component data)
---@param hashData boolean (Hash the value is true)
---@return any data (The foormatted table for component data)
function Components.formatComponentData(_data, hashData)
  hashData = GetValue(hashData, false)
  local data = table.copy(_data)
  if type(data) ~= "table" then
    data = { hash = data }
  end
  if table.type(data) == "array" then
    data = {
      hash = data[1] or 0,
      drawable = data[2],
      albedo = data[3],
      normal = data[4],
      material = data[5],
      palette = data[6],
      tint0 = data[7],
      tint1 = data[8],
      tint2 = data[9]
    }
  end
  if type(data.hash) == "table" then data = data.hash end --for VORP

  if hashData then
    for key, value in pairs(data) do
      data[key] = GetHashFromString(value)
    end
  end

  return data
end

--- A fonction to get the category hash from its string
---@param category string|integer (The category string)
---@return integer (The category hash)
function Components.getCategoryHash(category)
  if type(category) == "number" then return category end

  if category == "horse_feathers" then
    return -287556490
  end

  return joaat(category)
end


--- A function to get the head component hash from head index and skin tone
---@param ped integer (The entity ID)
---@param headIndex? integer (The head index, defaults to 1)
---@param skinTone? integer (The skin tone, defaults to 1)
---@return string (The head component hash string)
function Components.getHeadFromSkinTone(ped, headIndex, skinTone)
  local ped = ped or PlayerPedId()
  local sex = "M"
  if type(ped) == "string" then
    sex = (ped == "mp_male") and "M" or "F"
  else
    sex = IsPedMale(ped) and "M" or "F"
  end
  return ("CLOTHING_ITEM_%s_HEAD_%03d_V_%03d"):format(sex, headIndex or 1, skinTone or 1)
end

--- A function to get the lower body component hash from bodies index and skin tone
---@param ped integer|string (The entity ID or model name)
---@param bodiesIndex? integer (The bodies index, defaults to 1)
---@param skinTone? integer (The skin tone, defaults to 1)
---@return string (The lower body component hash string)
function Components.getBodiesLowerFromSkinTone(ped, bodiesIndex, skinTone)
  local ped = ped or PlayerPedId()
  local sex = "M"
  if type(ped) == "string" then
    sex = (ped == "mp_male") and "M" or "F"
  else
    sex = IsPedMale(ped) and "M" or "F"
  end
  return ("CLOTHING_ITEM_%s_BODIES_LOWER_%03d_V_%03d"):format(sex, bodiesIndex or 1, skinTone or 1)
end

--- A function to get the upper body component hash from bodies index and skin tone
---@param ped integer|string (The entity ID or model name)
---@param bodiesIndex? integer (The bodies index, defaults to 1)
---@param skinTone? integer (The skin tone, defaults to 1)
---@return string (The upper body component hash string)
function Components.getBodiesUpperFromSkinTone(ped, bodiesIndex, skinTone)
  local ped = ped or PlayerPedId()
  local sex = "M"
  if type(ped) == "string" then
    sex = (ped == "mp_male") and "M" or "F"
  else
    sex = IsPedMale(ped) and "M" or "F"
  end
  return ("CLOTHING_ITEM_%s_BODIES_UPPER_%03d_V_%03d"):format(sex, bodiesIndex or 1, skinTone or 1)
end

--- A function to get the eyes component hash from an index
---@param ped integer|string (The entity ID or model name)
---@param index? integer (The eyes index, defaults to 1)
---@return string (The eyes component hash string)
function Components.getEyesFromIndex(ped, index)
  local ped = ped or PlayerPedId()
  local sex = "M"
  if type(ped) == "string" then
    sex = (ped == "mp_male") and "M" or "F"
  else
    sex = IsPedMale(ped) and "M" or "F"
  end
  return ("CLOTHING_ITEM_%s_EYES_001_TINT_%03d"):format(sex, index or 1)
end

--- A function to get the teeth component hash from an index
---@param ped integer|string (The entity ID or model name)
---@param index? integer (The teeth index, defaults to 1)
---@return string (The teeth component hash string)
function Components.getTeethFromIndex(ped, index)
  local ped = ped or PlayerPedId()
  local sex = "M"
  if type(ped) == "string" then
    sex = (ped == "mp_male") and "M" or "F"
  else
    sex = IsPedMale(ped) and "M" or "F"
  end
  return ("CLOTHING_ITEM_%s_TEETH_%03d"):format(sex, index or 1)
end

function GetComponents()
    return Components
end

---------------------------------------
-- EXPORTS
---------------------------------------

exports("getComponents", function()
  return Components
end)