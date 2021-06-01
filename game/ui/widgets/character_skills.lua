-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"
local Skills = require "game.rules.skills"
local LabelPair = require "game.ui.widgets.label_pair"

local CharacterSkills = Components("character_skills", function(props)
  local characterSkills = props.characterSkills or {}
  return {
    width = "15%",
    {
      tables.mapKeys(characterSkills, function(value, key)
        return LabelPair {
          id = key,
          label = Skills.list[key].name,
          value = value
        }
      end)

    }
  }
end)

return CharacterSkills