-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("returns the terrain for the 8 neighbors for a tile", function()
  local getNeighborTerrain = require "game.rules.map.selectors.get_neighbor_terrain"
  local mapHelper = require "game.rules.map.helper"
  local terrain = require "game.rules.map.terrain"
  terrain.describe { key = "row1" }
  terrain.describe { key = "row2" }
  terrain.describe { key = "row3" }
  terrain.describe { key = "row4" }
  terrain.describe { key = "row5" }

  local map = mapHelper:new { width = 5, height = 5 }
  for x = 1,5 do
    map:setTerrain(x, 1, terrain.list.row1)
  end
  for x = 1,5 do
    map:setTerrain(x, 2, terrain.list.row2)
  end
  for x = 1,5 do
    map:setTerrain(x, 3, terrain.list.row3)
  end
  for x = 1,5 do
    map:setTerrain(x, 4, terrain.list.row4)
  end
  for x = 1,5 do
    map:setTerrain(x, 5, terrain.list.row5)
  end
  local state = {
    map = map
  }


  it("returns the neighbors for a specific tile location", function()
    local neighbors = getNeighborTerrain(state, 2, 3)
    assert.equals(terrain.list.row2, neighbors.nw)
    assert.equals(terrain.list.row2, neighbors.n)
    assert.equals(terrain.list.row2, neighbors.ne)
    assert.equals(terrain.list.row3, neighbors.w)
    assert.equals(terrain.list.row3, neighbors.e)
    assert.equals(terrain.list.row4, neighbors.se)
    assert.equals(terrain.list.row4, neighbors.s)
    assert.equals(terrain.list.row4, neighbors.sw)
  end)

  it("returns blank for tiles that are off the edge of the map", function()
    local neighbors = getNeighborTerrain(state, 1, 1)
    assert.equals(terrain.list.blank, neighbors.nw)
    assert.equals(terrain.list.blank, neighbors.n)
    assert.equals(terrain.list.blank, neighbors.ne)
    assert.equals(terrain.list.blank, neighbors.w)

    neighbors = getNeighborTerrain(state, 5, 1)
    assert.equals(terrain.list.blank, neighbors.ne)
    assert.equals(terrain.list.blank, neighbors.n)
    assert.equals(terrain.list.blank, neighbors.e)
    assert.equals(terrain.list.blank, neighbors.se)
  end)

end)