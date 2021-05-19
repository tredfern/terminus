-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.actions", function()
  local actions = require "game.rules.world.actions"

  describe("ACTION: addEntity", function()
    it("takes an entity to add to the database", function()
      local e1 = {}
      local action = actions.addEntity(e1)
      assert.equals(e1, action.payload.entity)
      assert.equals("ENTITY_ADD", action.type)
    end)
  end)

  describe("ACTION: removeEntity", function()
    it("identifies the entity to remove", function()
      local e1 = {}
      local action = actions.removeEntity(e1)
      assert.equals("ENTITY_REMOVE", action.type)
      assert.equals(e1, action.payload.entity)
    end)
  end)

  describe("ACTION: updateEntity", function()
    it("takes an entity ID and some properties to update", function()
      local entity = {}
      local values = {
        a = 1, b = 2, c = 3
      }
      local action = actions.updateEntity(
        entity,
        values
      )

      assert.equals("WORLD_ENTITY_UPDATE", action.type)
      assert.equals(entity, action.payload.entity)
      assert.equals(values, action.payload.values)
    end)
  end)
end)