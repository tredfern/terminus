-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.actions", function()
  local Actions = require "game.rules.aliens.actions"
  local Position = require "game.rules.world.position"

  it("ACTION: addAlien", function()
    local action = Actions.addAlien(Position(20, 39))
    local alien = action.payload.character
    assert.equals(20, alien.position.x)
    assert.equals(39, alien.position.y)
    assert.not_nil(alien.ai)
    assert.is_true(alien.alien)
    assert.not_nil(alien.animator)
  end)

  it("ACTION: addSpawner", function()
    local action = Actions.addSpawner(Position(38, 32))

    local spawner = action.payload.entity
    assert.equals(38, spawner.position.x)
    assert.equals(32, spawner.position.y)
    assert.not_nil(spawner.sprite)
    assert.is_true(spawner.spawner)
  end)

  it("ACTION: removeSpawner", function()
    local spawner = {}

    local action = Actions.removeSpawner(spawner)
    assert.equals(spawner, action.payload.entity)
  end)
end)
