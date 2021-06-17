-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions", function()
  local Actions = require "game.rules.combat.actions"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local Character = require "game.rules.character"
  local Skills = require "game.rules.skills"

  describe("ACTION: dealDamage", function()
    it("adjusts the characters health by a random die roll of the damage", function()
      local character = { health = 10 }
      local action = Actions.dealDamage(character, "1d6")
      local setHealth = moonpie.testing.simpleSpy()
      Character.actions.setHealth = setHealth

      action(mockDispatch)
      assert.spy(Character.actions.setHealth).was.called_with(character, match.in_range(4, 9))
    end)
  end)

  describe("ACTION: meleeAttack", function()
    local attacker, defender

    before_each(function()
      mockDispatch:reset()
      Skills.list.blade =  { key = "blade", attribute = "dexterity" }
      Skills.list.club =  { key = "club", attribute = "strength" }
      Skills.list.dodge =  { key = "dodge", attribute = "dexterity" }
      Skills.list.unarmed =  { key = "unarmed", attribute = "strength" }

      attacker = {
        name = "attacker",
        attributes = {
          dexterity = 10,
          strength = 0
        }
      }
      defender = { name = "defender",
        attributes = {
          dexterity = 0
        },
        health = 10
      }
    end)

    it("performs a task check for the combat check", function()
      local action = Actions.meleeAttack(attacker, defender)
      assert.thunk_dispatches_type("SKILLS_TASK_CHECK", action)
    end)
  end)

  describe("ACTION: meleeAttackSuccess", function()
    local attacker, defender, weapon = { name = "atkr" }, { name = "dfndr" }, { name = "wpn" }
    it("deals damage for the attack", function()
      local action = Actions.meleeAttackSuccess(attacker, defender, weapon)
      assert.thunk_dispatches_type("COMBAT_DEAL_DAMAGE", action)
    end)

    it("sends a message about the success", function()
      local action = Actions.meleeAttackSuccess(attacker, defender, weapon)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)
  end)

  describe("ACTION: meleeAttackFailure", function()
    local attacker, defender, weapon = { name = "atkr" }, { name = "dfndr" }, { name = "wpn" }
    it("sends a message about the failure", function()
      local action = Actions.meleeAttackFailure(attacker, defender, weapon)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)
  end)
end)