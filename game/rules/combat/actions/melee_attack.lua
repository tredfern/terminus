-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local Character = require "game.rules.character"
local EquipSlots = require "game.rules.character.equip_slots"
local MessageLog = require "game.rules.message_log"

local hitMessage = "%s attacks %s. The %s hits for %d points of damage! (%d / %d)"
local missMessage = "%s misses %s. (%d / %d)"

local function createSuccessResult(dispatch, attacker, defender, weapon)
  return function(target, roll)
    local damage = 1
    dispatch(MessageLog.actions.add(string.format(hitMessage,
      attacker.name, defender.name,
      weapon.name, damage, roll, target)))
    dispatch(Character.actions.setHealth(defender, defender.health - damage))
  end
end

local function createMissResult(dispatch, attacker, defender, _)
  return function(target, roll)
    dispatch(MessageLog.actions.add(string.format(missMessage, attacker.name, defender.name, roll, target)))
  end
end

return function(attacker, defender)
  return function(dispatch)
    -- get the weapon
    local weapon = attacker.inventory.equipSlots[EquipSlots.melee]
    if weapon == nil then return end
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