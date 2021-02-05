-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.helper", function()
  local mapHelper = require "game.rules.map.helper"

  it("sets width and height to 0 if not provided", function()
    local m = mapHelper:new()
    assert.equals(0, m.width)
    assert.equals(0, m.height)
  end)

  it("constructs a map with a width and height", function()
    local m = mapHelper:new {
      width = 32,
      height = 938
    }

    assert.equals(32, m.width)
    assert.equals(938, m.height)
  end)

  it("returns the terrain for a specific tile", function()
    local m = mapHelper:new { width = 320, height = 938 }
    local t = m:getTerrain(4, 9)
    assert.not_nil(t)
  end)

  it("has an empty room array to start", function()
    local m = mapHelper:new { width = 200, height = 200 }
    assert.not_nil(m.rooms)
  end)

  it("returns terrain.blank when requesting out of range", function()
    local terrain = require "game.rules.map.terrain"
    local m = mapHelper:new { width = 5, height = 5 }
    for x = 1, 5 do
      for y = 1, 5 do
        m:setTerrain(x, y, "filled")
      end
    end

    assert.equals(terrain.blank, m:getTerrain(6, 3))
    assert.equals(terrain.blank, m:getTerrain(3, 6))
    assert.equals(terrain.blank, m:getTerrain(-1, 3))
    assert.equals(terrain.blank, m:getTerrain(6, 53))
    assert.equals(terrain.blank, m:getTerrain(0, 0))
    assert.equals(terrain.blank, m:getTerrain(0, 3))
    assert.equals(terrain.blank, m:getTerrain(1, 0))
  end)
end)