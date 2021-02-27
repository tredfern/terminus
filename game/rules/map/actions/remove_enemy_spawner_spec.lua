-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.remove_enemy_spawner", function()
  local removeEnemySpawner = require "game.rules.map.actions.remove_enemy_spawner"

  it("identifies specifies the spawner to be removed", function()
    local spawner = {}

    local action = removeEnemySpawner(spawner)
    assert.equals(spawner, action.payload.spawner)
    assert.equals("REMOVE_ENEMY_SPAWNER", action.type)
  end)
end)