-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors", function()
  local Selectors = require "game.rules.map.selectors"
  local Position = require "game.rules.world.position"
  local state

  before_each(function()
    local terrain = require "game.rules.map.terrain"
    terrain.describe { key = "grass" }

    state = {
      map = {
        width = 200,
        height = 328,
        levels = 10,
        rooms = {},
        tiles = {
          [Position(5, 9, 2)] = { terrain = terrain.list.grass }
        }
      }
    }
  end)

  describe("SELECTOR: getDimensions", function()
    it("returns the width and height of the map", function()
      local dims = Selectors.getDimensions(state)
      assert.equals(200, dims.width)
      assert.equals(328, dims.height)
    end)

    it("returns zero if map is not set", function()
      local dims = Selectors.getDimensions({})
      assert.equals(0, dims.width)
      assert.equals(0, dims.height)
      assert.equals(0, dims.levels)
    end)

    it("returns the number of levels in the map", function()
      local dims = Selectors.getDimensions(state)
      assert.equals(10, dims.levels)
    end)
  end)

  describe("SELECTOR: getRooms", function()
    it("returns the rooms from the active map", function()
      assert.equals(state.map.rooms, Selectors.getRooms(state))
    end)
  end)

  describe("SELECTOR: getTerrain", function()
    local terrain = require "game.rules.map.terrain"
    it("returns terrain for a specific square", function()
      assert.equals(terrain.list.grass, Selectors.getTerrain(state, Position(5, 9, 2)))
      assert.equals(terrain.list.blank, Selectors.getTerrain(state, Position(150, 290)))
    end)
  end)

  describe("SELECTOR: getTile", function()
    it("returns the tile from a specific position", function()
      local t = Selectors.getTile(state, Position(5, 9, 2))
      assert.not_nil(t)
    end)
  end)

  describe("SELECTOR: getNeighbors", function()
    it("returns the tiles that surround a specific point", function()
      local state2 = {
        map = {
          tiles = {
            [Position(1, 1, 1)] = { id = 1 },
            [Position(2, 1, 1)] = { id = 2 },
            [Position(3, 1, 1)] = { id = 3 },
            [Position(1, 2, 1)] = { id = 4 },
            [Position(2, 2, 1)] = { id = 5 },
            [Position(3, 2, 1)] = { id = 6 },
            [Position(1, 3, 1)] = { id = 7 },
            [Position(2, 3, 1)] = { id = 8 },
            [Position(3, 3, 1)] = { id = 9 },
            [Position(2, 2, 0)] = { id = 10 },
            [Position(2, 2, 2)] = { id = 11 },
          }
        }
      }

      local neighbors = Selectors.getNeighbors(state2, Position(2, 2, 1))
      assert.equals(1, neighbors.nw.id)
      assert.equals(2, neighbors.n.id)
      assert.equals(3, neighbors.ne.id)
      assert.equals(4, neighbors.w.id)
      assert.equals(5, neighbors.center.id)
      assert.equals(6, neighbors.e.id)
      assert.equals(7, neighbors.sw.id)
      assert.equals(8, neighbors.s.id)
      assert.equals(9, neighbors.se.id)
      assert.equals(10, neighbors.down.id)
      assert.equals(11, neighbors.up.id)
    end)
  end)
end)