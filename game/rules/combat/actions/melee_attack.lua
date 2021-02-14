-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local EquipSlots = require "game.rules.character.equip_slots"
local MessageLog = require "game.rules.message_log"

local hitMessage = "%s hits %s!"
local missMessage = "%s misses %s."

local function createAttackResult(dispatch, attacker, defender, weapon)
  local Combat = require "game.rules.combat"

  return function(winner)
    if winner == defender then
      dispatch(MessageLog.actions.add(string.format(missMessage, attacker.name, defender.name)))
    else
      dispatch(MessageLog.actions.add(string.format(hitMessage, attacker.name, defender.name)))
      dispatch(Combat.actions.dealDamage(defender, weapon.damage))
    end
  end
end

return function(attacker, defender)
  if attacker == defender then return end
  return function(dispatch)
    -- get the weapon
    local weapon = attacker.inventory.equipSlots[EquipSlots.melee]
    if weapon == nil then
      weapon = { skill = "unarmed", damage = "1d3" }
    end
    -- Figure out skill and perform check
    local skill = Skills.chooseSkill.forItem(attacker, weapon)
    local defSkill = Skills.chooseSkill.forMeleeDefense(defender)
    local performAttack = Skills.actions.opposedCheck(
      attacker, skill,
      defender, defSkill,
      createAttackResult(dispatch, attacker, defender, weapon)
    )
    dispatch(performAttack)
  end
end