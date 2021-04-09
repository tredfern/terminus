-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.set_terrain", function()
  local setTerrain = require "game.rules.map.actions.set_terrain"

  it("specifies the location and type of terrain to set for a map", function()
    local map = {}
    local terrain = {}
    local action = setTerrain(map, 12, 32, terrain)

    assert.equals("MAP_SET_TERRAIN", action.type)
    assert.equals(map, action.payload.map)
    assert.equals(12, action.payload.x)
    assert.equals(32, action.payload.y)
    assert.equals(terrain, action.payload.terrain)
  end)
end)