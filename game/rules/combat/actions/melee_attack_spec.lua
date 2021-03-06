-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions.melee_attack", function()
  local MeleeAttack = require "game.rules.combat.actions.melee_attack"
  local attacker, defender, weapon, missWeapon
  local Skills = require "game.rules.skills"
  local MockDispatch = require "test_helpers.mock_dispatch"

  before_each(function()
    MockDispatch:reset()
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
      },
      inventory = { equipSlots = {} }
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
    MockDispatch.processComplex = true
  end)

  after_each(function()
    MockDispatch.processComplex = false
  end)

  it("makes a contested attack roll based on weapon and defender", function()
    attacker.inventory.equipSlots.melee = weapon
    spy.on(Skills.actions, "opposedCheck")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Skills.actions.opposedCheck).was.called_with(
      attacker, Skills.list.blade,
      defender, Skills.list.dodge,
      match.is_function())
  end)

  it("deals damage on successful hit", function()
    attacker.inventory.equipSlots.melee = weapon
    local Combat = require "game.rules.combat"
    spy.on(Combat.actions, "dealDamage")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Combat.actions.dealDamage).was.called_with(defender, weapon.damage)
  end)

  it("does not deal damage on a miss", function()
    attacker.inventory.equipSlots.melee = missWeapon
    local Character = require "game.rules.character"
    spy.on(Character.actions, "setHealth")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Character.actions.setHealth).was_not.called()
  end)

  it("uses unarmed weapon if no weapon equipped", function()
    attacker.inventory.equipSlots.melee = nil
    spy.on(Skills.actions, "opposedCheck")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Skills.actions.opposedCheck).was.called_with(
      attacker, Skills.list.unarmed,
      defender, Skills.list.dodge,
      match.is_function()
    )
  end)

  it("the defender can dodge out of the way", function()
    attacker.inventory.equipSlots.melee = weapon
    local Character = require "game.rules.character"
    spy.on(Character.actions, "setHealth")

    defender.skills.dodge = 20
    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Character.actions.setHealth).was_not.called()
  end)

  it("does not attack itself", function()
    assert.is_nil(MeleeAttack(attacker, attacker))
  end)

end)