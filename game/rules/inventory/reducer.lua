-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"
local types = require "game.rules.inventory.types"

local function getItemSlot(inventory, item)
  return tables.findFirst(inventory.carried, function(slot) return slot.item == item end)
end

local function getInventory(state, entity)
  if not state[entity] then
    state[entity] = {
      carried = {},
      equipped = {}
    }
  end

  return state[entity]
end

return createSlice {
  [types.ADD_ITEM] = function(state, action)
    local e, i = action.payload.entity, action.payload.item
    assert(e, "entity missing")
    assert(i, "item missing")

    local inventory = getInventory(state, e)

    local slot = getItemSlot(inventory, i)
    if not slot then
      slot = { item = i, quantity = 0 }
      table.insert(inventory.carried, slot)
    end

    slot.quantity = slot.quantity + 1

    return state
  end,

  [types.EQUIP_ITEM] = function(state, action)
    local e, i = action.payload.entity, action.payload.item
    assert(e, "entity missing")
    assert(i, "item missing")

    local inventory = getInventory(state, e)
    inventory.equipped[i.equipSlot] = i
    return state
  end,

  [types.REMOVE_ITEM] = function(state, action)
    local e, i = action.payload.entity, action.payload.item
    assert(e, "entity missing")
    assert(i, "item missing")

    local inventory = getInventory(state, e)

    local slot = getItemSlot(inventory, i)
    slot.quantity = slot.quantity - 1
    if slot.quantity == 0 then
      tables.removeItem(inventory.carried, slot)
    end

    return state
  end

}