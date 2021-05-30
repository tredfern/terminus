-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"
local types = require "game.rules.inventory.types"

local function getItemSlot(inventory, item)
  return tables.findFirst(inventory, function(slot) return slot.item == item end)
end

return createSlice {
  [types.ADD_ITEM] = function(state, action)
    local e, i = action.payload.entity, action.payload.item
    assert(e, "entity missing")
    assert(i, "item missing")
    state[e] = state[e] or { inventory = {} }

    local slot = getItemSlot(state[e].inventory, i)
    if not slot then
      slot = { item = i, quantity = 0 }
      table.insert(state[e].inventory, slot)
    end

    slot.quantity = slot.quantity + 1

    return state
  end,

  [types.REMOVE_ITEM] = function(state, action)
    local e, i = action.payload.entity, action.payload.item
    assert(e, "entity missing")
    assert(i, "item missing")

    local slot = getItemSlot(state[e].inventory, i)
    slot.quantity = slot.quantity - 1
    if slot.quantity == 0 then
      tables.removeItem(state[e].inventory, slot)
    end

    return state
  end

}