-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Row = require "game.ui.widgets.row"
local Attributes = require "game.rules.character.attributes"
local Character = require "game.rules.character"

local function getAttributeValue(character, attribute)
  return Character.selectors.getAttribute(nil, character, attribute)
end

local StatSummary = Components("stat_summary", function(props)
  local char = props.character
  return {
    Row({
      columns = 6,
      {
        columnWidth = 1,
        { Components.text { text = "STR:" } },
        { Components.text { text = "DEX:" } },
        { Components.text { text = "END:" } },
        { Components.text { text = "INT:" } },
        { Components.text { text = "KNL:" } },
        { Components.text { text = "CHA:" } },
      }, {
        id = "character_attributes",
        columnWidth = 1,
        { Components.text { text = getAttributeValue(char, Attributes.strength) } },
        { Components.text { text = getAttributeValue(char, Attributes.dexterity) } },
        { Components.text { text = getAttributeValue(char, Attributes.endurance) } },
        { Components.text { text = getAttributeValue(char, Attributes.intelligence) } },
        { Components.text { text = getAttributeValue(char, Attributes.knowledge) } },
        { Components.text { text = getAttributeValue(char, Attributes.charisma) } },
      },
      {
        id = "character_skills",
        columnWidth = 4,
      }
    })
  }
end)

return StatSummary