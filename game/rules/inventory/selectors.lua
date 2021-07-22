-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local EquipSlots = require "game.rules.inventory.equip_slots"

local selectors = {}


function selectors.getEquippedItem(state, entity, slot)
  local inventory = selectors.getInventory(state, entity)
  if inventory then
    return inventory.equipped[slot]
  end
end

function selectors.getInventory(state, entity)
  return state.inventory[entity]
end

function selectors.getRangedWeapon(state, entity)
  return selectors.getEquippedItem(state, entity, EquipSlots.ranged)
end

function selectors.isCarryingItem(state, entity, item)
  local inv = selectors.getInventory(state, entity)

  return tables.findFirst(inv.carried, function(slot) return slot.item == item end) ~= nil
end

return selectors