-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.update_frame", function()
  local updateFrame = require "game.rules.game_state.actions.update_frame"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

  before_each(function()
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("is has a type of update frame", function()
    local action = updateFrame(12)
    assert.equals("GAME_STATE_UPDATE_FRAME", action.type)
  end)

  it("updates graphics", function()
    mockDispatch(updateFrame())
    assert.is_true(mockDispatch:received_action("GRAPHICS_UPDATE_FRAME"))
  end)

end)