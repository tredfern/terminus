-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local store = require "game.store"

local labelPair = Components("characterAttributeLabelPair", function(props)
  local buttons = {
    display = "inline", padding = { right = 3 },
  }
  if props.editable then
    buttons[1] = Components.button { id = props.label .. "Increase", caption = "+", style = "button-small", }
    buttons[2] = Components.button { id = props.label .. "Decrease", caption = "-", style = "button-small", }
  end

  return {
    attribute = props.attribute,
    value = props.value,
    buttons,
    Components.text { text = props.label },
    Components.text { id = props.label .. "Stat", text = props.value, style ="align-right" },
  }
end)

return Components("character_attributes", function(props)
  local attributes = require "game.rules.character.attributes"
  local characterAttributes = props.attributes or {}

  return {
    width = "15%",
    labelPair {
      label = "Strength",
      value = characterAttributes[attributes.strength],
      editable = props.editable
    },
    labelPair {
      label = "Agility",
      value = characterAttributes[attributes.agility],
      editable = props.editable
    },
    labelPair {
      label = "Endurance",
      value = characterAttributes[attributes.endurance],
      editable = props.editable
    },
    labelPair {
      label = "Education",
      value = characterAttributes[attributes.education],
      editable = props.editable
    },
    labelPair {
      label = "Wit",
      value = characterAttributes[attributes.wit],
      editable = props.editable
    },
    labelPair {
      label = "Social",
      value = characterAttributes[attributes.social],
      editable = props.editable
    },
  }
end)