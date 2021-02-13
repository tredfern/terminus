-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_enemy_spawners", function()
  local getEnemySpawners = require "game.rules.map.selectors.get_enemy_spawners"

  it("returns all the enemy spawners", function()
    local e1, e2, e3 = {}, {}, {}
    local state = {
      map = {
        enemySpawners = { e1, e2, e3 }
      }
    }

    local result = getEnemySpawners(state)
    assert.array_includes(e1, result)
    assert.array_includes(e2, result)
    assert.array_includes(e3, result)
  end)

  it("returns an empty table if map or enemySpawners is nil", function()
    assert.same({}, getEnemySpawners({ map = {} }))
    assert.same({}, getEnemySpawners({}))
  end)
end)