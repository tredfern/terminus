-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions.attack", function()
  local attack = require "game.rules.combat.actions.attack"
  local mock_dispatch = require "mock_dispatch"

  it("reduces health by 1 from target", function()
    local character_action_types = require "game.rules.character.actions.types"
    local source = { attack = 100 }
    local target = { health = 8 , defense = 0}
    local atk = attack(source, target)
    atk(mock_dispatch)

    assert.is_true(mock_dispatch:received_action(
      character_action_types.character_set_health))
  end)

  it("returns empty action if source and target", function()
    local source = {}
    local target = source

    assert.same({}, attack(source, target))
  end)

  it("dispatches a message when an attack is performed", function()
    local message_types = require "game.rules.message_log.actions.types"
    local source = { attack = 100 }
    local target = { defense = 0, health = 8 }

    local atk = attack(source, target)
    atk(mock_dispatch)
    assert.is_true(mock_dispatch:received_action(
      message_types.message_log_add))
  end)

  it("rolls to resolve the attack", function()
    local helper = require "game.rules.combat.helper"
    spy.on(helper, "resolve_attack")

    local source = { attack = 100 }
    local target = { defense = 0, health = 8 }
    local atk = attack(source, target)
    atk(mock_dispatch)

    assert.spy(helper.resolve_attack).was.called_with(100, 0)
  end)
end)