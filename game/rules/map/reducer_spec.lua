-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.reducer", function()
  local reducer = require "game.rules.map.reducer"
  local types = require "game.rules.map.actions.types"

  it("sets the state to the value of the map on the set action", function()
    local map = {}
    local state = reducer({}, {
      type = types.ADD,
      payload = map
    })

    assert.equals(map, state)
  end)

  it("can update the terrain of a specific tile", function()
    local map = {}
    local terrain = {}
    local state = reducer(map, {
      type = types.SET_TERRAIN,
      payload = {
        map = map,
        x = 38,
        y = 29,
        terrain = terrain
      }
    })

    assert.equals(terrain, state[38][29].terrain)
  end)
end)