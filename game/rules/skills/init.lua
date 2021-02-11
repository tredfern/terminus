-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = {}
Skills.list = {}

function Skills.describe(props)
  Skills.list[props.key] = setmetatable(props, {
    __call = Skills.calculate
  })
end

function Skills.calculate(skill, character)
  local untrained = skill.untrained or 0
  return (character.attributes[skill.attribute] or 0) + (character.skills[skill.key] or untrained)
end

Skills.actions = {
  perform = require "game.rules.skills.actions.perform"
}
return Skills