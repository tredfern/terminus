-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.camera.reducer", function()
  local reducer = require "game.ui.camera.reducer"
  local types = require "game.ui.camera.actions.types"

  it("initial state has a camera", function()
    local s = reducer(nil, {})
    assert.not_nil(s)
    assert.equals(1, s.x)
    assert.equals(1, s.y)
  end)

  it("sets the position of the camera", function()
    local s = reducer({ }, {
      type = types.camera_set_position,
      payload = {
        x = 75,
        y = 118
      }
    })

    assert.equals(75, s.x)
    assert.equals(118, s.y)
  end)

  it("sets the dimensions of the camera", function()
    local s = reducer({}, {
      type = types.camera_set_dimensions,
      payload = {
        width = 28,
        height = 68
      }
    })

    assert.equals(28, s.width)
    assert.equals(68, s.height)
  end)
end)