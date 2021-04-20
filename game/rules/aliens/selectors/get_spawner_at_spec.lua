-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.selectors.get_spawner_at", function()
  local getSpawnerAt = require "game.rules.aliens.selectors.get_spawner_at"
  local position = require "game.rules.world.position"

  it("returns a spawner if at the specific location", function()
    local spawner = { position = position.new(12, 23), spawner = true }
    local state = {
      world = {
        spawner
      }
    }

    assert.equals(spawner, getSpawnerAt(state, position(12, 23)))
    assert.is_nil(getSpawnerAt(state, position(12, 28)))

  end)
end)