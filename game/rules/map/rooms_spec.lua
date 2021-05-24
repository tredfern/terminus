-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.generators.rooms", function()
  local room = require "game.rules.map.rooms"

  it("creates a generic room based on some coordinates", function()
    local r = room.rectangular(18, 32, 28, 20, 1)
    assert.equals(18, r.x)
    assert.equals(32, r.y)
    assert.equals(28, r.width)
    assert.equals(20, r.height)
    assert.equals(1, r.level)
    assert.equals(0, #r.features)
  end)
end)