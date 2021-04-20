-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs.ai.random_movement", function()
  local randomMovement = require "game.rules.npcs.ai.random_movement"
  local mockDispatch = require "test_helpers.mock_dispatch"

  it("dispatches a move action", function()
    local characterActionTypes = require "game.rules.character.actions.types"
    local character = { position = { x = 4, y = 8 } }
    randomMovement(character, mockDispatch)

    assert.is_true(mockDispatch:received_action(characterActionTypes.MOVE))
  end)

  it("dispatches a move action to a random adjacent square", function()
    local character = require "game.rules.character"
    local mockRandom = require "moonpie.test_helpers.mock_random"

    spy.on(character.actions, "move")
    mockRandom.setreturnvalues { 1, -1 }

    local c = { position = { x = 10, y = 25 } }
    randomMovement(c, mockDispatch)

    assert.spy(character.actions.move).was_called_with(c, match.is_position(11, 24))
  end)
end)