-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.add_item_to_inventory", function()
  local addItemToInventory = require "game.rules.character.actions.add_item_to_inventory"

  it("describes a character and item to add to inventory", function()
    local c = {}
    local item = {}
    local action = addItemToInventory(c, item)

    assert.equals("CHARACTER_ADD_ITEM_TO_INVENTORY", action.type)
    assert.equals(c, action.payload.character)
    assert.equals(item, action.payload.item)
  end)
end)