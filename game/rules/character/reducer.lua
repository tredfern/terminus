-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local createSlice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"

return createSlice {
  initial_state = { },

  [types.character_add] = function(state, action)
    return tables.concatArray(state, { action.payload.character })
  end,

  [types.character_add_item_to_inventory] = function(state, action)
    local character = action.payload.character
    character.inventory[#character.inventory + 1] = action.payload.item
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

    for i = 1, #character.inventory do
      if character.inventory[i] == item then
        table.remove(character.inventory, i)
        break
      end
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