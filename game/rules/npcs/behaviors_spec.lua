-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs.behaviors", function()
  local Behaviors = require "game.rules.npcs.behaviors"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

  describe("BEHAVIOR: moveTowardsPlayer", function()
    it("dispatches a move action in the direction of the player", function()
      local character = require "game.rules.character"
      spy.on(character.actions, "move")
      local enemy = { position = { x = 13, y = 18 } }
      local player = { position = { x = 29, y = 11 }, isPlayerControlled = true }

      local getState = function()
        return {
          characters = { enemy, player }
        }
      end

      Behaviors.moveTowardsPlayer(enemy, mockDispatch, getState)

      assert.spy(character.actions.move).was.called_with(enemy, match.is_position(14, 17))
      assert.is_true(mockDispatch:received_action(character.actions.types.MOVE))
    end)
  end)

  describe("BEHAVIOR: randomMovement", function()
    it("dispatches a move action", function()
      local characterActionTypes = require "game.rules.character.types"
      local character = { position = { x = 4, y = 8 } }
      Behaviors.randomMovement(character, mockDispatch)

      assert.is_true(mockDispatch:received_action(characterActionTypes.MOVE))
    end)

    it("dispatches a move action to a random adjacent square", function()
      local character = require "game.rules.character"
      local mockRandom = require "moonpie.test_helpers.mock_random"

      spy.on(character.actions, "move")
      mockRandom.setreturnvalues { 1, -1 }

      local c = { position = { x = 10, y = 25 } }
      Behaviors.randomMovement(c, mockDispatch)

      assert.spy(character.actions.move).was_called_with(c, match.is_position(11, 24))
    end)
  end)
end)