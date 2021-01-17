-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera.selectors.get", function()
  local get = require "game.rules.camera.selectors.get"

  it("returns the camera from state", function()
    local c = {}
    local state = {
      camera = c
    }

    assert.equals(c, get(state))
  end)
end)