-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local Thunk = require "moonpie.redux.thunk"
local Messages = require "assets.messages"
local Sounds = require "assets.sounds"
local Character = require "game.rules.character"
local MessageLog = require "game.rules.message_log"
local Skills = require "game.rules.skills"
local store = require "game.store"
local Selectors = require "game.rules.combat.selectors"
local types = require "game.rules.combat.types"

-- Define Module
local Actions = {}

-- For formatting messages
local function standardFormat(attacker, defender, weapon)
  return {
    attacker = attacker.name,
    defender = defender.name,
    weapon = weapon.name
  }
end

function Actions.dealDamage(character, damageDice)
  return Thunk(types.DEAL_DAMAGE, function(dispatch)
    local cup = Dice.parse(damageDice)
    local damage = cup()
    dispatch(Character.actions.setHealth(character, character.health - damage))
    dispatch(MessageLog.actions.add(
      Messages.combat.damage[1], {
        character = character.name,
        damage = damage
      })
    )
  end)
end

function Actions.meleeAttackSuccess(attacker, defender, weapon)
  local msgData = standardFormat(attacker, defender, weapon)
  return Thunk(types.MELEE_ATTACK_SUCCESS, function(dispatch)
    Sounds.hit:play()
    dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.melee.hit[1], msgData))
    dispatch(Actions.dealDamage(defender, weapon.damage))
  end)
end

function Actions.meleeAttackFailure(attacker, defender, weapon)
  local msgData = standardFormat(attacker, defender, weapon)
  return Thunk(types.MELEE_ATTACK_FAILURE, function(dispatch)
    dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.melee.miss[1], msgData))
  end)
end

function Actions.meleeAttack(attacker, defender)
  if attacker == defender then return end
  return function(dispatch)
    -- get the weapon
    local weapon = Selectors.getMeleeWeapon(store.getState(), attacker)

    -- Figure out skill and perform check
    local modifiers = { }

    -- Play the attack sound effect
    Sounds.attack:play()
    dispatch(
      Skills.actions.taskCheck(modifiers,
        Actions.meleeAttackSuccess(attacker, defender, weapon),
        Actions.meleeAttackFailure(attacker, defender, weapon))
    )
  end
end

function Actions.rangedAttackSuccess(attacker, defender, weapon)
  local msgData = standardFormat(attacker, defender, weapon)
  return Thunk(types.RANGE_ATTACK_SUCCESS, function(dispatch)
    Sounds.hit:play()
    dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.ranged.hit[1], msgData))
    dispatch(Actions.dealDamage(defender, weapon.damage))
  end)
end

function Actions.rangedAttackFailure(attacker, defender, weapon)
  local msgData = standardFormat(attacker, defender, weapon)
  return Thunk(types.RANGE_ATTACK_FAILURE, function(dispatch)
    dispatch(MessageLog.actions.add(MessageLog.messages.combat.attacks.ranged.miss[1], msgData))
  end)
end

function Actions.rangedAttack(attacker, defender)
  local FieldOfView = require "game.rules.field_of_view"
  local Inventory = require "game.rules.inventory"
  return Thunk(
    types.RANGED_ATTACK,
    function(dispatch, getState)
      local weapon = Inventory.selectors.getRangedWeapon(store.getState(), attacker)
      local modifiers = {}

      if FieldOfView.selectors.checkLineOfSight(getState(), attacker.position, defender.position) then
        dispatch(
          Skills.actions.taskCheck(modifiers,
            Actions.rangedAttackSuccess(attacker, defender, weapon),
            Actions.rangedAttackFailure(attacker, defender, weapon)
          )
        )
      end
    end)
end

return Actions