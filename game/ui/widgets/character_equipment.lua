-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local function getItemName(item)
  if item == nil then return "" end
  return item.name
end

return Components("character_equipment", function(props)
  local equipSlots = props.equipSlots or {}
  return {
    width = "15%",
    {
      Components.text { text = "Melee: " },
      Components.text { id = "meleeItem", text = getItemName(equipSlots.melee), style = "align-right" }
    }
  }
end)