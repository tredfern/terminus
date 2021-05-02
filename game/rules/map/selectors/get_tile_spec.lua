-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_tile", function()
  local getTile = require "game.rules.map.selectors.get_tile"
  local tileMap = require "game.rules.map.tile_map"
  local Position = require "game.rules.world.position"

  it("returns the tile from a specific position", function()
    local map = tileMap:new()
    map:updateTile(Position(5, 9, 2), {  })
    local state = {
      map = {
        tileMap = map
      }
    }

    local t = getTile(state, Position(5, 9, 2))
    assert.equals(map:getTile(Position(5, 9, 2)), t)
  end)
end)