-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens", function()
  local Aliens = require "game.rules.aliens"
  local Position = require "game.rules.world.position"

  it("ACTION: addAlien", function()
    local action = Aliens.actions.addAlien(Position(20, 39))
    local alien = action.payload.character
    assert.equals(20, alien.position.x)
    assert.equals(39, alien.position.y)
    assert.not_nil(alien.ai)
    assert.is_true(alien.alien)
    assert.not_nil(alien.animator)
  end)

  it("ACTION: addSpawner", function()
    local action = Aliens.actions.addSpawner(Position(38, 32))

    local spawner = action.payload.entity
    assert.equals(38, spawner.position.x)
    assert.equals(32, spawner.position.y)
    assert.not_nil(spawner.sprite)
    assert.is_true(spawner.spawner)
  end)

  it("ACTION: removeSpawner", function()
    local spawner = {}

    local action = Aliens.actions.removeSpawner(spawner)
    assert.equals(spawner, action.payload.entity)
  end)

  it("SELECTOR: getSpawnerAt", function()
    local spawner = { position = Position(12, 23), spawner = true }
    local state = {
      world = {
        spawner
      }
    }

    assert.equals(spawner, Aliens.selectors.getSpawnerAt(state, Position(12, 23)))
    assert.is_nil(Aliens.selectors.getSpawnerAt(state, Position(12, 28)))
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

    local result = Aliens.selectors.getSpawners(state)
    assert.array_includes(spawner, result)
    assert.not_array_includes(notSpawner, result)
  end)
end)
