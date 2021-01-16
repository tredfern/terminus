-- Copyright (c) 2021 Trevor Redfern
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera.reducer", function()
  local reducer = require "game.rules.camera.reducer"
  local types = require "game.rules.camera.actions.types"

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
end)