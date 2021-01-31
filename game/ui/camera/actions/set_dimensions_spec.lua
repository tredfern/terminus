-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.camera.actions.set_dimensions", function()
  local set_dimensions = require "game.ui.camera.actions.set_dimensions"

  it("takes a width and height for the camera to be", function()
    local action = set_dimensions(48, 293)
    assert.equals("CAMERA_SET_DIMENSIONS", action.type)
    assert.equals(48, action.payload.width)
    assert.equals(293, action.payload.height)
  end)
end)