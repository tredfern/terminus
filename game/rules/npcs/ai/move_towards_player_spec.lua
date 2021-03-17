-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs.ai.move_towards_player", function()
  local moveTowardsPlayer = require "game.rules.npcs.ai.move_towards_player"
  local mockDispatch = require "test_helpers.mock_dispatch"

  it("dispatches a move action in the direction of the player", function()
    local character = require "game.rules.character"
    spy.on(character.actions, "move")
    local enemy = { x = 13, y = 18 }
    local player = { x = 29, y = 11, isPlayerControlled = true }

    local getState = function()
      return {
        characters = { enemy, player }
      }
    end

    moveTowardsPlayer(enemy, mockDispatch, getState)

    assert.spy(character.actions.move).was.called_with(enemy, 14, 17)
    assert.is_true(mockDispatch:received_action(character.actions.types.MOVE))
  end)
end)