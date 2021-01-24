-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.map", function()
  local map = require "game.rules.map.map"

  it("sets width and height to 0 if not provided", function()
    local m = map:new()
    assert.equals(0, m.width)
    assert.equals(0, m.height)
  end)

  it("constructs a map with a width and height", function()
    local m = map:new {
      width = 32,
      height = 938
    }

    assert.equals(32, m.width)
    assert.equals(938, m.height)
  end)

  it("returns the terrain for a specific tile", function()
    local m = map:new { width = 320, height = 938 }
    local t = m:get_terrain(4, 9)
    assert.not_nil(t)
  end)

  it("has an empty room array to start", function()
    local m = map:new { width = 200, height = 200 }
    assert.not_nil(m.rooms)
  end)
end)