-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.map", function()
  local map = require "game.rules.map.map"

  it("constructs a map with a width and height", function()
    local m = map:new {
      width = 32,
      height = 938
    }

    assert.equals(32, m.width)
    assert.equals(938, m.height)
  end)
end)