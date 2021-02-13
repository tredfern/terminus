-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.add_enemy_spawner", function()
  local addEnemySpawner = require "game.rules.map.actions.add_enemy_spawner"

  it("takes an x, y for the enemy spawner to be created at", function()
    local action = addEnemySpawner(16, 28)
    assert.equals(16, action.payload.x)
    assert.equals(28, action.payload.y)
    assert.equals("MAP_ADD_ENEMY_SPAWNER", action.type)
  end)
end)