-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.selectors.get_spawner_at", function()
  local getSpawnerAt = require "game.rules.aliens.selectors.get_spawner_at"

  it("returns a spawner if at the specific location", function()
    local spawner = { x = 12, y = 23, spawner = true }
    local state = {
      world = {
        spawner
      }
    }

    assert.equals(spawner, getSpawnerAt(state, 12, 23))
    assert.is_nil(getSpawnerAt(state, 12, 28))

  end)
end)