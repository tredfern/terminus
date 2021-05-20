-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war.actions", function()
  local Actions = require "game.rules.fog_of_war.actions"
  local Position = require "game.rules.world.position"
  local mockStore = require "moonpie.test_helpers.mock_store"

  describe("ACTION: updatePerspective", function()
    local visibilityMap = require "game.rules.field_of_view.visibility_map"

    it("takes a perspective and updates it's fog of war for each position", function()
      local perspective = {}
      local vm = visibilityMap:new()
      vm:setVisible(Position(1, 1, 1))
      local state = {
        fieldOfView = {
          [perspective] = vm
        }
      }
      mockStore(state)

      local action = Actions.updatePerspective(perspective)
      assert.equals("FOG_OF_WAR_UPDATE_PERSPECTIVE", action.type)
      assert.thunk_dispatches_type(action, "FOG_OF_WAR_UPDATE_POSITION")
    end)
  end)

  describe("game.rules.fog_of_war.actions.update", function()
    it("takes a perspective, position, and tile information seen to track in FoW database", function()
      local entity, position, tile = {}, {}, {}
      local action = Actions.updatePosition(entity, position, tile)

      assert.equals("FOG_OF_WAR_UPDATE_POSITION", action.type)
      assert.equals(entity, action.payload.perspective)
      assert.equals(position, action.payload.position)
      assert.equals(tile, action.payload.tile)
    end)

    it("can take a hashKey for position", function()
      local entity, hash, tile = {}, 1234, {}
      local action = Actions.updatePosition(entity, hash, tile)
      assert.equals(hash, action.payload.positionHashKey)
    end)
  end)
end)