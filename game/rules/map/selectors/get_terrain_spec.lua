-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_terrain", function()
  local map = require "game.rules.map.map"
  local terrain = require "game.rules.map.terrain"
  local get_terrain = require "game.rules.map.selectors.get_terrain"

  it("returns terrain for a specific square", function()
    local m = map:new { width = 100, height = 100 }
    m:set_terrain(5, 9, terrain.grass)
    assert.equals(terrain.grass, get_terrain({ map = m }, 5, 9))
    assert.equals(terrain.blank, get_terrain({ map = m }, 150, 290))
  end)
end)