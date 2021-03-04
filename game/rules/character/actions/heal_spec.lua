-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.heal", function()
  local heal = require "game.rules.character.actions.heal"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local types = require "game.rules.character.actions.types"

  it("dispatches an update to set the character health to a higher value", function()
    local character = { health = 10 }
    local action = heal(character)

    action(mockDispatch)
    assert.is_true(mockDispatch:received_action(types.character_set_health))

  end)
end)