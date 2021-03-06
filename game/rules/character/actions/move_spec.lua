-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.move", function()
  local MOVE = require "game.rules.character.actions.move"
  local types = require "game.rules.character.actions.types"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local wrap_in_function = require "wrap_in_function"
  local Skills = require "game.rules.skills"
  local Attributes = require "game.rules.character.attributes"

  before_each(function()
    Skills.describe { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
  end)

  it("dispatches a set_position message to move the character to the correct coordinates", function()
    local c = {}
    local state = {
      characters = { c }
    }
    local action = MOVE(c, 19, 10)

    action(mockDispatch, wrap_in_function(state))
    assert.is_true(mockDispatch:received_action(types.SET_POSITION))
  end)

  it("creates a melee attack action if there is another character in the square attempting to move to", function()
    local Combat = require "game.rules.combat"
    spy.on(Combat.actions, "meleeAttack")
    local player = { }
    local enemy = { x = 20, y = 11 }
    local state = {
      characters = {
        player, enemy
      }
    }

    local action = MOVE(player, 20, 11)
    action(mockDispatch, wrap_in_function(state))

    assert.spy(Combat.actions.meleeAttack).was.called_with(player, enemy)
  end)
end)