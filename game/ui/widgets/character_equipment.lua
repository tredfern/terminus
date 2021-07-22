-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local LabelPair = require "game.ui.widgets.label_pair"
local equipSlots = require "game.rules.inventory.equip_slots"

local function getItemName(item)
  if item == nil then return "" end
  return item.name
end

return Components("character_equipment", function(props)
  props.equipped = props.equipped or {}
  return {
    width = "15%",
    LabelPair { id = "meleeItem", label = "Melee", value = getItemName(props.equipped[equipSlots.melee]) }
  }
end)