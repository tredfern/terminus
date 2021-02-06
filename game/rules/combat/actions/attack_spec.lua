-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions.attack", function()
  local attack = require "game.rules.combat.actions.attack"
  local mock_dispatch = require "mock_dispatch"
  local attacker = {
    skills = {
      unarmed = { getScore = function() return 20 end }
    }
  }

  it("reduces health by 1 from target", function()
    local character_action_types = require "game.rules.character.actions.types"
    local target = { health = 8 }
    local atk = attack(attacker, target)
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
    local target = { defense = 0, health = 8 }

    local atk = attack(attacker, target)
    atk(mock_dispatch)
    assert.is_true(mock_dispatch:received_action(
      message_types.message_log_add))
  end)

  it("rolls to resolve the attack", function()
    local helper = require "game.rules.combat.helper"
    spy.on(helper, "attackRoll")

    local target = { health = 8 }
    local atk = attack(attacker, target)
    atk(mock_dispatch)

    assert.spy(helper.attackRoll).was.called_with(20)
  end)
end)