-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local label_value = require "game.ui.widgets.label_value"

local attributes = components("character_attributes", function(props)
  return {
    attributes = props.character_attributes,
    render = function(self)
      return {
        label_value ({
          id = "strength_attribute",
          label = "Strength",
          value = self.attributes.strength.score }),
        label_value ({
          id = "dexterity_attribute",
          label = "Dexterity",
          value = self.attributes.dexterity.score }),
        label_value ({
          id = "endurance_attribute",
          label = "Endurance",
          value = self.attributes.endurance.score }),
        label_value ({
          id = "intelligence_attribute",
          label = "Intelligence",
          value = self.attributes.intelligence.score }),
        label_value ({
          id = "knowledge_attribute",
          label = "Knowledge",
          value = self.attributes.knowledge.score }),
        label_value ({
          id = "personality_attribute",
          label = "Personality",
          value = self.attributes.personality.score }),
      }
    end

  }
end)

return connect(attributes,
  function(state) return { character_attributes = state.player.attributes } end)