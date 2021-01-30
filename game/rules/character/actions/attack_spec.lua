-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.attack", function()
  local attack = require "game.rules.character.actions.attack"
  local types = require "game.rules.character.actions.types"
  local mock_dispatch = require "mock_dispatch"

  it("reduces health by 1 from target", function()
    local source, target = {}, { health = 8 }
    local state = {
      characters = { source, target }
    }
    local atk = attack(source, target)
    atk(mock_dispatch, state)
    assert.is_true(mock_dispatch:received_action(types.character_set_health))
  end)

  it("returns empty action if source and target", function()
    local source = {}
    local target = source

    assert.same({}, attack(source, target))
  end)

  it("dispatches a message when an attack is performed", function()
    local message_types = require "game.rules.message_log.actions.types"
    local source, target = {}, { health = 8 }
    local state = {
      characters = { source, target }
    }

    local atk = attack(source, target)
    atk(mock_dispatch, state)
    assert.is_true(mock_dispatch:received_action(
      message_types.message_log_add))
  end)
end)