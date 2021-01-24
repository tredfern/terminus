-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.generators.path", function()
  local path = require "game.rules.map.generators.path"

  it("can connect 2 points using 2 straight lines", function()
    local p = path.straight(1, 1, 3, 3)
    -- s x x
    --     x
    --     e
    assert.equals(1, p[1].x)
    assert.equals(1, p[1].y)
    assert.equals(2, p[2].x)
    assert.equals(1, p[2].y)
    assert.equals(3, p[3].x)
    assert.equals(1, p[3].y)
    assert.equals(3, p[4].x)
    assert.equals(2, p[4].y)
    assert.equals(3, p[5].x)
    assert.equals(3, p[5].y)
  end)
end)