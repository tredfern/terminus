-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local LabelPair = require "game.ui.widgets.label_pair"

local function getItemName(item)
  if item == nil then return "" end
  return item.name
end

return Components("character_equipment", function(props)
  local equipSlots = props.equipSlots or {}
  return {
    width = "15%",
    LabelPair { id = "meleeItem", label = "Melee", value = getItemName(equipSlots.melee) }
  }
end)