-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Character = require "game.rules.character"
local Dice = require "moonpie.math.dice"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"
local Skills = require "game.rules.skills"
local Sounds = require "assets.sounds"
local store = require "game.store"

-- Define Module
local Combat = {
  actions = {},
  selectors = require "game.rules.combat.selectors"
}

-- For formatting messages
local function standardFormat(attacker, defender, weapon)
  return {
    attacker = attacker.name,
    defender = defender.name,
    weapon = weapon.name
  }
end

-- For resolving attacks
local function createAttackResult(dispatch, attacker, defender, weapon)
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

function Combat.actions.dealDamage(character, damageDice)
  return function(dispatch)
    local cup = Dice.parse(damageDice)
    local damage = cup()
    dispatch(Character.actions.setHealth(character, character.health - damage))
    dispatch(MessageLog.actions.add(
      Messages.combat.damage[1], {
        character = character.name,
        damage = damage
      })
    )
  end
end

function Combat.actions.meleeAttack(attacker, defender)
  if attacker == defender then return end
  return function(dispatch)
    -- get the weapon
    local weapon = Combat.selectors.getMeleeWeapon(store.getState(), attacker)

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

return Combat