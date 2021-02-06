-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterHelper = {}
local dice = require "moonpie.math.dice"

function characterHelper.createDefaultAbilities()
  local cup = dice.parse("3d6")
  return {
    strength = cup(),
    agility = cup(),
    endurance = cup(),
    wit = cup(),
    education = cup(),
    social = cup()
  }
end

function characterHelper.createDefaultSkills(character)
  local skills = require "game.rules.character.skills"
  return {
    throwing = skills.newSkill("Throwing", character, "agility"),
    blade = skills.newSkill("Blade", character, "agility"),
    unarmed = skills.newSkill("Unarmed", character, "strength"),
    handgun = skills.newSkill("Handgun", character, "agility")

  }
end

function characterHelper.newCharacter(props)
  props = props or {}
  local c = {
    x = props.x or 0,
    y = props.y or 0,
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    health = 10,
    attack = 50,
    defense = 50,
    abilities = characterHelper.createDefaultAbilities()
  }

  c.skills = characterHelper.createDefaultSkills(c)
  return c
end

return characterHelper