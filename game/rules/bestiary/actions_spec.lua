-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.bestiary.actions", function()
  local Actions = require "game.rules.bestiary.actions"

  describe("ACTION: addNew", function()
    it("creates a new entity and adds it to the world", function()
      local entity, position = {}, {}

      local action = Actions.add(entity, position)
      assert.equals("ENTITY_ADD", action.type)
      assert.equals(entity, action.payload.entity)
      assert.equals(position, entity.position)
    end)
  end)
end)