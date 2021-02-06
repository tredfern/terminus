-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = {}

function Skills.getScore(skill)
  return skill.character.abilities[skill.ability]
end

function Skills.newSkill(name, character, ability)
  return {
    name = name,
    getScore = Skills.getScore,
    character = character,
    ability = ability
  }
end



return Skills