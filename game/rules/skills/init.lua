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
  opposedCheck = require "game.rules.skills.actions.opposed_check",
  perform = require "game.rules.skills.actions.perform",
}
Skills.chooseSkill = require "game.rules.skills.choose_skill"
return Skills