-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_dimensions", function()
  local get_dimensions = require "game.rules.map.selectors.get_dimensions"

  local state = {
    map = {
      outline = {
        width = 200,
        height = 328,
        levels = 10
      }
    }
  }

  it("returns the width and height of the map", function()
    local dims = get_dimensions(state)
    assert.equals(200, dims.width)
    assert.equals(328, dims.height)
  end)

  it("returns zero if map is not set", function()
    local dims = get_dimensions({})
    assert.equals(0, dims.width)
    assert.equals(0, dims.height)
  end)

  it("returns the number of levels in the map", function()
    local dims = get_dimensions(state)
    assert.equals(10, dims.levels)
  end)
end)