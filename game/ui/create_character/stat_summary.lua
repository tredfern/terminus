-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local Row = require "game.ui.widgets.row"
local Attributes = require "game.rules.character.attributes"
local Character = require "game.rules.character"

local StatSummary = Components("stat_summary", function(props)
  return {
    character = props.character,
    characterAttributes = props.characterAttributes,
    render = function(self)
      local attributeValues = self.characterAttributes
      return Row({
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
          { Components.text { text = attributeValues[Attributes.strength].value } },
          { Components.text { text = attributeValues[Attributes.dexterity].value } },
          { Components.text { text = attributeValues[Attributes.endurance].value } },
          { Components.text { text = attributeValues[Attributes.intelligence].value } },
          { Components.text { text = attributeValues[Attributes.knowledge].value } },
          { Components.text { text = attributeValues[Attributes.charisma].value } },
        },
        {
          id = "character_skills",
          columnWidth = 4,
        }
      })
    end
  }
end)

return connect(StatSummary, function(state, component)
  return {
    characterAttributes = Character.selectors.getAttributes(state, component.character)
  }
end)