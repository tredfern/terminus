-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.actions.add", function()
  local add = require "game.rules.items.actions.add"
  local Items = require "game.rules.items"

  it("takes an item to add", function()
    Items.describe { key = "item_to_add" }

    local action = add(Items.list.item_to_add,  { x = 5, y = 8 })

    assert.not_equal(Items.list.item_to_add, action.payload.entity)
    assert.equals(Items.list.item_to_add.key, action.payload.entity.key)
    assert.equals(5, action.payload.entity.x)
    assert.equals(8, action.payload.entity.y)
    assert.equals("ENTITY_ADD", action.type)
  end)
end)