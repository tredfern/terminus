-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

local selectors = {}


function selectors.getInventory(state, entity)
  return state.inventory[entity]
end

function selectors.isCarryingItem(state, entity, item)
  local inv = selectors.getInventory(state, entity)

  return tables.findFirst(inv.carried, function(slot) return slot.item == item end) ~= nil
end

return selectors