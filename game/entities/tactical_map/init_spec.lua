-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.tactical_map", function()
  local tactical_map = require "game.entities.tactical_map"

  it("can be initialized to a set width and height", function()
    local m = tactical_map:new(50, 50)
    assert.equals(50, m.width)
    assert.equals(50, m.height)
  end)
end)