-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local function createLabelPair(label, value)
  return {
    Components.text { text = label },
    Components.text { id = label .. "Stat", text = value, style ="align-right" }
  }
end

return Components("character_attributes", function(props)
  local attributes = require "game.rules.character.attributes"
  local characterAttributes = props.attributes or {}

  return {
    width = "15%",
    createLabelPair("Strength", characterAttributes[attributes.strength]),
    createLabelPair("Agility", characterAttributes[attributes.agility]),
    createLabelPair("Endurance", characterAttributes[attributes.endurance]),
    createLabelPair("Wit", characterAttributes[attributes.wit]),
    createLabelPair("Education", characterAttributes[attributes.education]),
    createLabelPair("Social", characterAttributes[attributes.social]),
  }
end)