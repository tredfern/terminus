-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.graphics.actions.update_frame", function()
  local updateFrame = require "game.rules.graphics.actions.update_frame"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local mockStore = require "test_helpers.mock_store"
  local state

  before_each(function()
    state = {
      world = {
        { animator = { update = spy.new(function() end), getCurrentFrame = function() return {} end } },
        { animator = { update = spy.new(function() end), getCurrentFrame = function() return {} end }}
      }
    }
    mockStore(state)
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("is treated as a thunk with an action type", function()
    local action = updateFrame(1)
    assert.equals("GRAPHICS_UPDATE_FRAME", action.type)
  end)

  it("updates the animator with the delta time", function()
  end)

  it("fetches all entities with animators and updates their current frame", function()
    mockDispatch(updateFrame(29.3))
    assert.not_nil(state.world[1].sprite)
    assert.not_nil(state.world[2].sprite)
  end)
end)