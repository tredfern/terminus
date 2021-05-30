-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.actions", function()
  local actions = require "game.rules.inventory.actions"

  it("ACTION: addItem", function()
    local item = {}
    local entityId = {}

    local action = actions.addItem(entityId, item)
    assert.equals("INVENTORY_ADD_ITEM", action.type)
    assert.equals(entityId, action.payload.entity)
    assert.equals(item, action.payload.item)
  end)

  it("ACTION: removeItem", function()
    local item = {}
    local entityId = {}

    local action = actions.removeItem(entityId, item)
    assert.equals("INVENTORY_REMOVE_ITEM", action.type)
    assert.equals(entityId, action.payload.entity)
    assert.equals(item, action.payload.item)
  end)


  describe("ACTION: equipItem", function()
    it("defines what should be equipped", function()
      local item = {}
      local entityId = {}

      local action = actions.equipItem(entityId, item)
      assert.equals("INVENTORY_EQUIP_ITEM", action.type)
      assert.equals(entityId, action.payload.entity)
      assert.equals(item, action.payload.item)
    end)
  end)
end)