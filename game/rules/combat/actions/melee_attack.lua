-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local EquipSlots = require "game.rules.character.equip_slots"
local MessageLog = require "game.rules.message_log"
local Sounds = require "assets.sounds"

local function standardFormat(attacker, defender, weapon)
  return {
    attacker = attacker.name,
    defender = defender.name,
    weapon = weapon.name
  }
end

local function createAttackResult(dispatch, attacker, defender, weapon)
  local Combat = require "game.rules.combat"
  local msgData = standardFormat(attacker, defender, weapon)

  return function(winner)
    if winner == defender then
      dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.melee.miss[1], msgData))
    else
      Sounds.hit:play()
      dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.melee.hit[1], msgData))
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
    Sounds.attack:play()
    local performAttack = Skills.actions.opposedCheck(
      attacker, skill,
      defender, defSkill,
      createAttackResult(dispatch, attacker, defender, weapon)
    )
    dispatch(performAttack)
  end
end