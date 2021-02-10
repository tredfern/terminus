-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions.melee_attack", function()
  local MeleeAttack = require "game.rules.combat.actions.melee_attack"
  local attacker, defender, weapon, missWeapon
  local Skills = require "game.rules.skills"
  local MockDispatch = require "mock_dispatch"

  before_each(function()
    Skills.describe { key = "blade", attribute = "dexterity" }
    Skills.describe { key = "club", attribute = "strength" }

    attacker = {
      attributes = {
        dexterity = 10,
        strength = 3
      },
      skills = {
        blade = 8,
        club = -1
      },
      inventory = { equipSlots = {} }
    }
    defender = { health = 10 }
    weapon = { skills = { "blade" } }
    missWeapon = { skills = { "club" }}
    MockDispatch.processComplex = true
  end)

  after_each(function()
    MockDispatch.processComplex = false
  end)

  it("makes an attack roll based on the a source skill using the item to attack with", function()
    attacker.inventory.equipSlots.melee = weapon
    spy.on(Skills.actions, "perform")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Skills.actions.perform).was.called_with(Skills.list.blade,
      attacker,
      match.is_function(),
      match.is_function())
  end)

  it("deals damage on successful hit", function()
    attacker.inventory.equipSlots.melee = weapon
    local Character = require "game.rules.character"
    spy.on(Character.actions, "setHealth")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Character.actions.setHealth).was.called_with(defender, defender.health - 1)
  end)

  it("does not deal damage on a miss", function()
    attacker.inventory.equipSlots.melee = missWeapon
    local Character = require "game.rules.character"
    spy.on(Character.actions, "setHealth")

    local action = MeleeAttack(attacker, defender)
    action(MockDispatch)

    assert.spy(Character.actions.setHealth).was_not.called()
  end)

  it("does nothing if no weapon equipped", function()
    attacker.inventory.equipSlots.melee = nil
    local action = MeleeAttack(attacker, defender)
    assert.has_no_errors(action)
  end)
end)