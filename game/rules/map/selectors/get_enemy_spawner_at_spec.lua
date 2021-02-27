-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_enemy_spawner_at", function()
  local getEnemySpawnerAt = require "game.rules.map.selectors.get_enemy_spawner_at"

  it("returns an enemy spawner that is at a specific location", function()
    local findMe = { x = 29, y = 32 }
    local state = {
      map = {
        enemySpawners = {
          findMe
        }
      }
    }

    assert.equals(findMe, getEnemySpawnerAt(state, 29, 32))
  end)

  it("returns nil if no enemy spawner is found", function()
    local state = { map = { } }
    assert.is_nil(getEnemySpawnerAt(state, 32, 18))
  end)
end)