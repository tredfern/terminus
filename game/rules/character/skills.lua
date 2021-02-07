-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = {}

function Skills:define(props)
  Skills[props.key] = setmetatable(props, {
    __call = Skills.calculate
  })
end

function Skills.calculate(skill, character)
  local untrained = skill.untrained or 0
  return (character.attributes[skill.attribute] or 0) + (character.skills[skill.key] or untrained)
end

local function setupDefault()
  local attributes = require "game.rules.character.attributes"
  Skills:define { name = "Unarmed", key = "unarmed", attribute = attributes.strength }
  Skills:define { name = "Blade", key = "blade", attribute = attributes.agility }
  Skills:define { name = "Handgun", key = "handgun", attribute = attributes.agility }
  Skills:define { name = "Throwing", key = "throwing", attribute = attributes.agility }
end

setupDefault()

return setmetatable(Skills, {
  __call = Skills.define
})