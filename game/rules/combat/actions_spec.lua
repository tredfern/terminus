-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions", function()
  local Actions = require "game.rules.combat.actions"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local Character = require "game.rules.character"
  local Skills = require "game.rules.skills"
  local Position = require "game.rules.world.position"

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

  describe("ACTION: rangedAttack", function()
    local attacker = { position = Position(1, 1, 1) }
    local defender = { position = Position(1, 3, 1) }

    before_each(function()
      local Inventory = require "game.rules.inventory"
      stub(Inventory.selectors, "getRangedWeapon", { name = "ranged weapon" })
    end)

    after_each(function()
      local Inventory = require "game.rules.inventory"
      Inventory.selectors.getRangedWeapon:revert()
    end)

    it("is identified as the ranged attack action", function()
      local action = Actions.rangedAttack(attacker, defender)
      assert.equals("COMBAT_RANGED_ATTACK", action.type)
    end)

    it("checks whether the points have a clear path", function()
      local fov = require "game.rules.field_of_view"
      local action = Actions.rangedAttack(attacker, defender)
      stub(fov.selectors, "checkLineOfSight", false)
      assert.not_thunk_dispatches_type("SKILLS_TASK_CHECK", action)
      fov.selectors.checkLineOfSight:revert()
    end)

    it("performs a task check for the weapon", function()
      local action = Actions.rangedAttack(attacker, defender)
      assert.thunk_dispatches_type("SKILLS_TASK_CHECK", action)
    end)
  end)

  describe("ACTION: rangedAttackSuccess", function()
    local attacker, defender, weapon = { name = "atkr" }, { name = "dfndr" }, { name = "wpn" }
    it("sends a message about the success", function()
      local action = Actions.rangedAttackFailure(attacker, defender, weapon)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)
  end)

  describe("ACTION: rangedAttackFailure", function()
    local attacker, defender, weapon = { name = "atkr" }, { name = "dfndr" }, { name = "wpn" }
    it("sends a message about the failure", function()
      local action = Actions.rangedAttackFailure(attacker, defender, weapon)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)
  end)
end)