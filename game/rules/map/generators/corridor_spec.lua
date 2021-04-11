-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.generators.corridor", function()
  local corridor = require "game.rules.map.generators.corridor"

  it("create a corridor with a start and end point", function()
    local c = corridor(17, 29, 19, 22)
    assert.equals(17, c.startX)
    assert.equals(29, c.startY)
    assert.equals(19, c.endX)
    assert.equals(22, c.endY)
  end)

  it("maps a sequence of tiles that represent the path between two points", function()
    local c = corridor(10, 10, 12, 12)
    assert.equals(10, c.path[1].x)
    assert.equals(10, c.path[1].y)
    assert.equals(11, c.path[2].x)
    assert.equals(10, c.path[2].y)
    assert.equals(12, c.path[3].x)
    assert.equals(10, c.path[3].y)
    assert.equals(12, c.path[4].x)
    assert.equals(11, c.path[4].y)
    assert.equals(12, c.path[5].x)
    assert.equals(12, c.path[5].y)
  end)
end)