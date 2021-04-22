-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.actions.add_spawner", function()
  local addSpawner = require "game.rules.aliens.actions.add_spawner"
  local Position = require "game.rules.world.position"

  it("adds a spawner with a position", function()
    local action = addSpawner(Position(38, 32))

    local spawner = action.payload.entity
    assert.equals(38, spawner.position.x)
    assert.equals(32, spawner.position.y)
    assert.not_nil(spawner.sprite)
    assert.is_true(spawner.spawner)
  end)
end)