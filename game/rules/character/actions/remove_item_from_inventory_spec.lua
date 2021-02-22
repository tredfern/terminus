-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.remove_item_from_inventory", function()
  local removeItemFromInventory = require "game.rules.character.actions.remove_item_from_inventory"

  it("tracks the character and item of inventory to remove", function()
    local item = {}
    local character = {}
    local action = removeItemFromInventory(character, item)
    assert.equals(character, action.payload.character)
    assert.equals(item, action.payload.item)
    assert.equals("CHARACTER_REMOVE_ITEM_FROM_INVENTORY", action.type)

  end)
end)