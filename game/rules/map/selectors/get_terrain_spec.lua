-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.getTerrain", function()
  local mapHelper = require "game.rules.map.helper"
  local terrain = require "game.rules.map.terrain"
  local getTerrain = require "game.rules.map.selectors.get_terrain"

  it("returns terrain for a specific square", function()
    terrain.describe { key = "grass" }
    local m = mapHelper:new { width = 100, height = 100 }
    m:setTerrain(5, 9, terrain.list.grass)
    assert.equals(terrain.list.grass, getTerrain({ map = m }, 5, 9))
    assert.equals(terrain.list.blank, getTerrain({ map = m }, 150, 290))
  end)
end)