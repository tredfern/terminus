-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors", function()
  local Selectors = require "game.rules.map.selectors"
  local Position = require "game.rules.world.position"
  local state

  before_each(function()
    local tileMap = require "game.rules.map.tile_map"
    local terrain = require "game.rules.map.terrain"
    terrain.describe { key = "grass" }

    local map = tileMap:new()
    map:updateTile(Position(5, 9, 2), { terrain = terrain.list.grass })

    state = {
      map = {
        width = 200,
        height = 328,
        levels = 10,
        outline = {
          rooms = {}
        },
        tileMap = map
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
      assert.equals(state.map.outline.rooms, Selectors.getRooms(state))
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
end)