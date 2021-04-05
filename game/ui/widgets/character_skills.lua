-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"
local Skills = require "game.rules.skills"
local LabelPair = require "game.ui.widgets.label_pair"

return Components("character_skills", function(props)
  local skillData = {}
  for _, v in pairs(Skills.list) do
    skillData[#skillData + 1] = {
      skill = v,
      score = v(props.character)
    }
  end
  return {
    width = "15%",
    {
      tables.map(skillData, function(s)
        return LabelPair {
          id = s.skill.key,
          label = s.skill.name,
          value = s.score
        }
      end)

    }
  }
end)