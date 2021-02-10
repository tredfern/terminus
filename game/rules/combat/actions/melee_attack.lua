-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local Character = require "game.rules.character"
local EquipSlots = require "game.rules.character.equip_slots"
local MessageLog = require "game.rules.message_log"

local attackMessage = "%s is attacking %s with their %s..."
local hitMessage = "and hits (%d/%d) for %d points of damage!"
local missMessage = "and misses! (%d/%d)"

local function createSuccessResult(dispatch, _, defender, _)
  return function(target, roll)
    local damage = 1
    dispatch(MessageLog.actions.add(string.format(hitMessage, roll, target, damage)))
    dispatch(Character.actions.setHealth(defender, defender.health - damage))
  end
end

local function createMissResult(dispatch, _, _, _)
  return function(target, roll)
    dispatch(MessageLog.actions.add(string.format(missMessage, roll, target)))
  end
end

return function(attacker, defender)
  return function(dispatch)
    -- get the weapon
    local weapon = attacker.inventory.equipSlots[EquipSlots.melee]
    if weapon == nil then return end
    dispatch(MessageLog.actions.add(string.format(attackMessage, attacker.name, defender.name, weapon.name)))
    -- Figure out skill and perform check
    local skill = Skills.list[weapon.skills[1]]
    local performAttack = Skills.actions.perform(
      skill, attacker,
      createSuccessResult(dispatch, attacker, defender, weapon),
      createMissResult(dispatch, attacker, defender, weapon)
    )
    dispatch(performAttack)
  end
end