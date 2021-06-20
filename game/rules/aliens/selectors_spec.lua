-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.selectors", function()
  local Selectors = require "game.rules.aliens.selectors"
  local Position = require "game.rules.world.position"

  it("SELECTOR: getSpawnerAt", function()
    local spawner = { position = Position(12, 23), spawner = true }
    local state = {
      world = {
        spawner
      }
    }

    assert.equals(spawner, Selectors.getSpawnerAt(state, Position(12, 23)))
    assert.is_nil(Selectors.getSpawnerAt(state, Position(12, 28)))
  end)

  it("SELECTOR: getSpawners", function()
    local spawner = { spawner = true }
    local notSpawner = {}
    local state = {
      world = {
        spawner,
        notSpawner
      }
    }

    local result = Selectors.getSpawners(state)
    assert.array_includes(spawner, result)
    assert.not_array_includes(notSpawner, result)
  end)
end)
