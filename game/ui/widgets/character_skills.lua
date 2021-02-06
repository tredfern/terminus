-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"

return Components("character_skills", function(props)
  local skills = props.character.skills or {}
  local skillData = {}
  for k, v in pairs(skills) do
    skillData[#skillData + 1] = {
      name = k,
      skill = v
    }
  end
  return {
    width = "15%",
    {
      tables.map(skillData, function(s)
        return {
          Components.text { text = s.skill.name },
          Components.text { id = s.name .. "Skill", text = s.skill:getScore(), style = "align-right" }
        }
      end)

    }
  }
end)