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

return setmetatable(Skills, {
  __call = Skills.define
})