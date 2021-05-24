-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs.actions", function()
  local Actions = require "game.rules.npcs.actions"
  local mockRandom = require "moonpie.test_helpers.mock_random"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

  describe("ACTION: checkSpawnEnemy", function()
    it("takes an enemy spawner and spawns enemy if passes check", function()
      local action = Actions.checkSpawnEnemy({ position = { x = 18, y = 38 } })
      mockRandom.setreturnvalues({ 1 })
      assert.thunk_dispatches_type("CHARACTER_ADD", action)
    end)

    it("does nothing if does not meet skill check", function()
      local action = Actions.checkSpawnEnemy({ position = { x = 12, y = 19 } })
      mockRandom.setreturnvalues({ 18 })
      assert.not_thunk_dispatches_type("CHARACTER_ADD", action)
    end)
  end)

  describe("ACTION: game.rules.npcs.actions.think", function()
    it("calls the ai routine for the enemy", function()
      local enemy = {
        ai = spy.new(function() end)
      }
      local getState = function() end
      local action = Actions.think(enemy)
      action(mockDispatch, getState)

      assert.spy(enemy.ai).was.called_with(enemy, mockDispatch, getState)
    end)
  end)
end)