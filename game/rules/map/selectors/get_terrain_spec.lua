-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.getTerrain", function()
  local tileMap = require "game.rules.map.tile_map"
  local terrain = require "game.rules.map.terrain"
  local getTerrain = require "game.rules.map.selectors.get_terrain"

  it("returns terrain for a specific square", function()
    terrain.describe { key = "grass" }
    local map = tileMap:new()
    map:updateTile(5, 9, { terrain = terrain.list.grass })
    local state = {
      map = {
        tileMap = map
      }
    }
    assert.equals(terrain.list.grass, getTerrain(state, 5, 9))
    assert.equals(terrain.list.blank, getTerrain(state, 150, 290))
  end)
end)