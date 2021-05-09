-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs.actions.check_spawn_enemy", function()
  local checkSpawnEnemy = require "game.rules.npcs.actions.check_spawn_enemy"
  local mockRandom = require "moonpie.test_helpers.mock_random"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

  before_each(function()
    mockDispatch:reset()
  end)

  it("takes an enemy spawner and spawns enemy if passes check", function()
    local action = checkSpawnEnemy({ position = { x = 18, y = 38 } })
    mockRandom.setreturnvalues({ 1 })
    action(mockDispatch)

    assert.is_true(mockDispatch:received_action("CHARACTER_ADD"))
  end)

  it("does nothing if does not meet skill check", function()
    local action = checkSpawnEnemy({ position = { x = 12, y = 19 } })
    mockRandom.setreturnvalues({ 18 })
    action(mockDispatch)

    assert.is_false(mockDispatch:received_action("CHARACTER_ADD"))
  end)

  it("attaches an ai to the newly created character", function()
    local action = checkSpawnEnemy({ position = { x = 12, y = 19 } })
    mockRandom.setreturnvalues({ 1 })
    action(mockDispatch)

    assert.not_nil(mockDispatch.dispatched[1].payload.character.ai)
  end)
end)