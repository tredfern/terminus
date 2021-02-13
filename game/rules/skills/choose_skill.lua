-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local chooseSkill = {}

function chooseSkill.forItem(_, item)
  local Skills = require "game.rules.skills"
  return Skills.list[item.skill]
end

function chooseSkill.forMeleeDefense(_)
  local Skills = require "game.rules.skills"
  return Skills.list.dodge
end


return chooseSkill