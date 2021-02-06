-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterHelper = {}

function characterHelper.createDefaultAbilities()
  return {
    strength = 10,
    agility = 10,
    endurance = 10,
    wit = 10,
    education = 10,
    social = 10
  }
end

function characterHelper.newCharacter(props)
  props = props or {}
  return {
    x = props.x or 0,
    y = props.y or 0,
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    health = 10,
    attack = 50,
    defense = 50,
    abilities = characterHelper.createDefaultAbilities()
  }
end

return characterHelper