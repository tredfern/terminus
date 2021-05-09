-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war.actions.update_perspective", function()
  local updatePerspective = require "game.rules.fog_of_war.actions.update_perspective"
  local visibilityMap = require "game.rules.field_of_view.visibility_map"
  local Position = require "game.rules.world.position"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"

  before_each(function()
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

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

    local action = updatePerspective(perspective)
    assert.equals("FOG_OF_WAR_UPDATE_PERSPECTIVE", action.type)
    mockDispatch(action)

    assert.is_true(mockDispatch:received_action("FOG_OF_WAR_UPDATE_POSITION"))
  end)
end)