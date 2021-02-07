-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"
local Character = require "game.rules.character"

return Components("character_skills", function(props)
  local skillData = {}
  for _, v in pairs(Character.skills.list) do
    skillData[#skillData + 1] = {
      skill = v,
      score = v(props.character)
    }
  end
  return {
    width = "15%",
    {
      tables.map(skillData, function(s)
        return {
          Components.text { text = s.skill.name },
          Components.text { id = s.skill.key .. "Skill", text = s.score, style = "align-right" }
        }
      end)

    }
  }
end)