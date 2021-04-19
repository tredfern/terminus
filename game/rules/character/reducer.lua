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
  [types.ADD] = function(state, action)
    return tables.concatArray(state, { action.payload.character })
  end,

  [types.ADD_ITEM_TO_INVENTORY] = function(state, action)
    local character = action.payload.character
    local slot = findItemInInventory(character.inventory, action.payload.item)
    if slot then
      slot.quantity = slot.quantity + 1
    else
      character.inventory[#character.inventory + 1] = createInventorySlot(action.payload.item)
    end
    return state
  end,

  [types.EQUIP_ITEM] = function(state, action)
    local character = action.payload.character
    local item = action.payload.item
    character.inventory.equipSlots[item.equipSlot] = item
    return state
  end,

  [types.REMOVE] = function(state, action)
    return tables.select(state,
    function(character)
      if character ~= action.payload.character then
        return character
      end
    end)
  end,

  [types.REMOVE_ITEM_FROM_INVENTORY] = function(state, action)
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

  [types.SET_ATTRIBUTE] = function(state, action)
    local character = action.payload.character
    character.attributes[action.payload.attribute] = action.payload.value
    return state
  end,

  [types.SET_HEALTH] = function(state, action)
    local colors = require "game.rules.graphics.colors"
    local c = action.payload.character
    c.health = action.payload.health
    if c.sprite then
      if c.health < 10 then
        c.sprite.color = colors.lowHealth
      else
        c.sprite.color = colors.drawDefault
      end
    end
    return state
  end,

  [types.SET_NAME] = function(state, action)
    local c = action.payload.character
    c.name = action.payload.name
    return state
  end,

  [types.SET_POSITION] = function(state, action)
    local c = action.payload.character
    c.position.x = action.payload.x
    c.position.y = action.payload.y
    return state
  end,
}