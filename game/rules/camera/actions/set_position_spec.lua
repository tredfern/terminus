-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera.actions.set_position", function()
  local set_position = require "game.rules.camera.actions.set_position"

  it("takes an x and y for the camera location", function()
    local sp = set_position(38, 94)
    assert.equals("CAMERA_SET_POSITION", sp.type)
    assert.equals(38, sp.payload.x)
    assert.equals(94, sp.payload.y)
  end)
end)