-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.selectors.get_spawners", function()
  local getSpawners = require "game.rules.aliens.selectors.get_spawners"

  it("returns spawners from the world", function()
    local spawner = { spawner = true }
    local notSpawner = {}
    local state = {
      world = {
        spawner,
        notSpawner
      }
    }

    local result = getSpawners(state)
    assert.array_includes(spawner, result)
    assert.not_array_includes(notSpawner, result)
  end)
end)