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

Skills.actions = require "game.rules.skills.actions"
Skills.chooseSkill = require "game.rules.skills.choose_skill"
Skills.selectors = require "game.rules.skills.selectors"
Skills.reducer = require "game.rules.skills.reducer"

return Skills