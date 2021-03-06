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
      type = types.SET,
      payload = map
    })

    assert.equals(map, state)
  end)

  it("can add enemy spawners to the map", function()
    local map = { width = 100, height = 100 }
    local state = reducer(map, {
      type = types.ADD_ENEMY_SPAWNER,
      payload = { x = 12, y = 15 }
    })

    assert.equals(12, state.enemySpawners[1].x)
    assert.equals(15, state.enemySpawners[1].y)
  end)

  it("can remove enemy spawners from the map", function()
    local spawner = { }
    local state = {
      enemySpawners = { spawner }
    }


    state = reducer(state, { type = types.REMOVE_ENEMY_SPAWNER, payload = { spawner = spawner } })
    assert.equals(0, #state.enemySpawners)
  end)
end)