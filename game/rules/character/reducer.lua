-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local createSlice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"

local function createInventorySlot(item)
  return {
    item = item,
    quantity = 1
  }
end

local function findItemInInventory(inventory, item)
  return tables.findFirst(inventory, function(i) return i.item.key == item.key end)
end

return createSlice {
  initial_state = { },

  [types.character_add] = function(state, action)
    return tables.concatArray(state, { action.payload.character })
  end,

  [types.character_add_item_to_inventory] = function(state, action)
    local character = action.payload.character
    local slot = findItemInInventory(character.inventory, action.payload.item)
    if slot then
      slot.quantity = slot.quantity + 1
    else
      character.inventory[#character.inventory + 1] = createInventorySlot(action.payload.item)
    end
    return state
  end,

  [types.character_equip_item] = function(state, action)
    local character = action.payload.character
    local item = action.payload.item
    character.inventory.equipSlots[item.equipSlot] = item
    return state
  end,

  [types.character_remove] = function(state, action)
    return tables.select(state,
    function(character)
      if character ~= action.payload.character then
        return character
      end
    end)
  end,

  [types.remove_item_from_inventory] = function(state, action)
    local character = action.payload.character
    local item = action.payload.item
    local slot, index = findItemInInventory(character.inventory, item)
    if slot.quantity > 1 then
      slot.quantity = slot.quantity - 1
    else
      table.remove(character.inventory, index)
    end

    return state
  end,

  [types.character_set_health] = function(state, action)
    local c = action.payload.character
    c.health = action.payload.health
    return state
  end,

  [types.character_set_name] = function(state, action)
    local c = action.payload.character
    c.name = action.payload.name
    return state
  end,

  [types.character_set_position] = function(state, action)
    local c = action.payload.character
    c.x = action.payload.x
    c.y = action.payload.y
    return state
  end,
}