-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("returns the terrain for the 8 neighbors for a tile", function()
  local getNeighborTerrain = require "game.rules.map.selectors.get_neighbor_terrain"
  local mapHelper = require "game.rules.map.helper"
  local terrain = require "game.rules.map.terrain"

  local map = mapHelper:new { width = 5, height = 5 }
  for x = 1,5 do
    map:setTerrain(x, 1, terrain.corridor)
  end
  for x = 1,5 do
    map:setTerrain(x, 2, terrain.room)
  end
  for x = 1,5 do
    map:setTerrain(x, 3, terrain.dirt)
  end
  for x = 1,5 do
    map:setTerrain(x, 4, terrain.grass)
  end
  for x = 1,5 do
    map:setTerrain(x, 5, terrain.wall)
  end
  local state = {
    map = map
  }


  it("returns the neighbors for a specific tile location", function()
    local neighbors = getNeighborTerrain(state, 2, 3)
    assert.equals(terrain.room, neighbors.nw)
    assert.equals(terrain.room, neighbors.n)
    assert.equals(terrain.room, neighbors.ne)
    assert.equals(terrain.dirt, neighbors.w)
    assert.equals(terrain.dirt, neighbors.e)
    assert.equals(terrain.grass, neighbors.se)
    assert.equals(terrain.grass, neighbors.s)
    assert.equals(terrain.grass, neighbors.sw)
  end)

  it("returns blank for tiles that are off the edge of the map", function()
    local neighbors = getNeighborTerrain(state, 1, 1)
    assert.equals(terrain.blank, neighbors.nw)
    assert.equals(terrain.blank, neighbors.n)
    assert.equals(terrain.blank, neighbors.ne)
    assert.equals(terrain.blank, neighbors.w)

    neighbors = getNeighborTerrain(state, 5, 1)
    assert.equals(terrain.blank, neighbors.ne)
    assert.equals(terrain.blank, neighbors.n)
    assert.equals(terrain.blank, neighbors.e)
    assert.equals(terrain.blank, neighbors.se)
  end)

end)