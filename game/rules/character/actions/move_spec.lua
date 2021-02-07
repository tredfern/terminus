-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.move", function()
  local character_move = require "game.rules.character.actions.move"
  local types = require "game.rules.character.actions.types"
  local mock_dispatch = require "mock_dispatch"
  local wrap_in_function = require "wrap_in_function"
  local Skills = require "game.rules.character.skills"
  local Attributes = require "game.rules.character.attributes"

  before_each(function()
    Skills:define { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
  end)

  it("dispatches a set_position message to move the character to the correct coordinates", function()
    local c = {}
    local state = {
      characters = { c }
    }
    local action = character_move(c, 19, 10)

    action(mock_dispatch, wrap_in_function(state))
    assert.is_true(mock_dispatch:received_action(types.character_set_position))
  end)

  it("dispatches an attack action if there is another character in the square attempting to move to", function()
    local player = {
      attributes = {
        [Attributes.strength] = 10
      },
      skills = {
        unarmed = 0
      }
    }
    local enemy = { x = 20, y = 11 }
    local state = {
      characters = {
        player, enemy
      }
    }

    local action = character_move(player, 20, 11)
    action(mock_dispatch, wrap_in_function(state))

    local combat_action_types = require "game.rules.combat.actions.types"
    assert.is_true(mock_dispatch:received_action(
      combat_action_types.combat_attack))
  end)
end)