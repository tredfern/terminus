-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local Character = require "game.rules.character"
local EquipSlots = require "game.rules.character.equip_slots"
local MessageLog = require "game.rules.message_log"

local hitMessage = "%s hits %s for %d points of damage!"
local missMessage = "%s misses %s."

local function createAttackResult(dispatch, attacker, defender)
  return function(winner)
    if winner == defender then
      dispatch(MessageLog.actions.add(string.format(missMessage, attacker.name, defender.name)))
    else
      local damage = 1
      dispatch(MessageLog.actions.add(string.format(hitMessage, attacker.name, defender.name, damage)))
      dispatch(Character.actions.setHealth(defender, defender.health - damage))
    end
  end
end

return function(attacker, defender)
  return function(dispatch)
    -- get the weapon
    local weapon = attacker.inventory.equipSlots[EquipSlots.melee]
    if weapon == nil then return end
    -- Figure out skill and perform check
    local skill = Skills.chooseSkill.forItem(attacker, weapon)
    local defSkill = Skills.chooseSkill.forMeleeDefense(defender)
    local performAttack = Skills.actions.opposedCheck(
      attacker, skill,
      defender, defSkill,
      createAttackResult(dispatch, attacker, defender)
    )
    dispatch(performAttack)
  end
end