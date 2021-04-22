-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.generators.room", function()
  local room = require "game.rules.map.generators.room"

  it("creates a room based on some coordinates", function()
    local r = room(18, 32, 28, 20, 1)
    assert.equals(18, r.x)
    assert.equals(32, r.y)
    assert.equals(28, r.width)
    assert.equals(20, r.height)
    assert.equals(1, r.level)
    assert.equals(0, #r.features)
  end)
end)