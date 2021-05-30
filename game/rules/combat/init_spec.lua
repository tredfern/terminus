-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat", function()
  local Combat = require "game.rules.combat"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Character = require "game.rules.character"
  local Skills = require "game.rules.skills"
  local equipSlots = require "game.rules.inventory.equip_slots"

  describe("actions.deal_damage", function()
    it("adjusts the characters health by a random die roll of the damage", function()
      local character = { health = 10 }
      local action = Combat.actions.dealDamage(character, "1d6")
      local setHealth = moonpie.testing.simpleSpy()
      Character.actions.setHealth = setHealth

      action(mockDispatch)
      assert.spy(Character.actions.setHealth).was.called_with(character, match.in_range(4, 9))
    end)
  end)

  describe("actions.melee_attack", function()
    local attacker, defender, weapon, missWeapon

    before_each(function()
      mockDispatch:reset()
      Skills.describe { key = "blade", attribute = "dexterity" }
      Skills.describe { key = "club", attribute = "strength" }
      Skills.describe { key = "dodge", attribute = "dexterity" }
      Skills.describe { key = "unarmed", attribute = "strength" }

      attacker = {
        name = "attacker",
        attributes = {
          dexterity = 10,
          strength = 3
        },
        skills = {
          blade = 8,
          club = -1,
          unarmed = 20
        }
      }
      defender = { name = "defender",
        attributes = {
          dexterity = 3
        },
        skills = { dodge = 0 },
        health = 10
      }
      weapon = { name = "weapon", skill = "blade", damage = "1d8"  }
      missWeapon = { name = "missWeapon", skill = "club", damage = "1d10" }
      mockDispatch.processComplex = true
    end)

    after_each(function()
      mockDispatch.processComplex = false
    end)

    it("makes a contested attack roll based on weapon and defender", function()
      mockStore {
        inventory = {
          [attacker] = {
            equipped = {
              [equipSlots.MELEE] = weapon
            }
          }
        }
      }

      spy.on(Skills.actions, "opposedCheck")

      local action = Combat.actions.meleeAttack(attacker, defender)
      action(mockDispatch)

      assert.spy(Skills.actions.opposedCheck).was.called_with(
        attacker, Skills.list.blade,
        defender, Skills.list.dodge,
        match.is_function())
    end)

    it("deals damage on successful hit", function()
      mockStore {
        inventory = {
          [attacker] = {
            equipped = {
              [equipSlots.MELEE] = weapon
            }
          }
        }
      }
      spy.on(Combat.actions, "dealDamage")

      local action = Combat.actions.meleeAttack(attacker, defender)
      action(mockDispatch)

      assert.spy(Combat.actions.dealDamage).was.called_with(defender, weapon.damage)
      Combat.actions.dealDamage:revert()
    end)

    it("does not deal damage on a miss", function()
      mockStore {
        inventory = {
          [attacker] = {
            equipped = {
              [equipSlots.MELEE] = missWeapon
            }
          }
        }
      }
      local action = Combat.actions.meleeAttack(attacker, defender)
      assert.not_thunk_dispatches_type("CHARACTER_SET_HEALTH", action)
    end)

    it("uses unarmed weapon if no weapon equipped", function()
      mockStore {
        inventory = {
          [attacker] = {
            equipped = { }
          }
        }
      }
      spy.on(Skills.actions, "opposedCheck")

      local action = Combat.actions.meleeAttack(attacker, defender)
      action(mockDispatch)

      assert.spy(Skills.actions.opposedCheck).was.called_with(
        attacker, Skills.list.unarmed,
        defender, Skills.list.dodge,
        match.is_function()
      )
    end)

    it("the defender can dodge out of the way", function()
      mockStore {
        inventory = {
          [attacker] = {
            equipped = {
              [equipSlots.MELEE] = weapon
            }
          }
        }
      }

      defender.skills.dodge = 20
      local action = Combat.actions.meleeAttack(attacker, defender)
      assert.not_thunk_dispatches_type("CHARACTER_SET_HEALTH", action)
    end)

    it("does not attack itself", function()
      assert.is_nil(Combat.actions.meleeAttack(attacker, attacker))
    end)
  end)
end)