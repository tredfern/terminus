-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.actions", function()
  local Actions = require "game.rules.field_of_view.actions"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Position = require "game.rules.world.position"

  describe("ACTION: calculateAll", function()
    before_each(function()
      mockStore {
        world = {
          { position = Position(1, 3, 2), sightRadius = 6 },
          { position = Position(1, 3, 2), sightRadius = 4 }
        }
      }
    end)

    it("finds all entities with sight enabled and calculates their visibility maps", function()
      local action = Actions.calculateAll()
      assert.equals("FIELD_OF_VIEW_CALCULATE_ALL", action.type)
      assert.thunk_dispatches_type("FIELD_OF_VIEW_CALCULATE", action, 2)
    end)
  end)

  describe("ACTION: calculate", function()
    it("calculates the field of view and then updates", function()
      local entity = {}
      local position = Position(4, 2, 3)

      local action = Actions.calculate(entity, position, 3)
      assert.equals("FIELD_OF_VIEW_CALCULATE", action.type)
      assert.thunk_dispatches_type("FIELD_OF_VIEW_UPDATE", action)
    end)
  end)

  describe("ACTION: update", function()
    it("takes an entity id, origin and visibility map for the field of view", function()
      local entity = {}
      local map = {}
      local action = Actions.update(entity, map)
      assert.equals("FIELD_OF_VIEW_UPDATE", action.type)
      assert.equals(entity, action.payload.entity)
      assert.equals(map, action.payload.visibilityMap)
    end)
  end)
end)