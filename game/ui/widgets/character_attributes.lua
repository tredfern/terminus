-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local store = require "game.store"
local attributes = require "game.rules.character.attributes"
local Spinner = require "game.ui.widgets.spinner"

local attrLabelPair = Components("characterAttributeLabelPair", function(props)
  local attrValue = Components.text { id = props.attribute .. "Value", text = props.value, style ="align-right" }
  if props.editable then
    attrValue = Spinner {
      style = "align-right",
      id = props.attribute .. "Value",
      value = props.value,
      eventUpdated = function(component)
        store.dispatch(Character.actions.setAttribute(props.character, props.attribute, component.value))
      end,
    }
  end
  return {
    character = props.character,
    attribute = props.attribute,
    value = props.value,
    editable = props.editable,
    label = props.label,

    Components.text { id = props.attribute .. "Label", text = props.label },
    attrValue
  }
end)

return Components("character_attributes", function(props)
  local characterAttributes = props.attributes or {}

  return {
    width = "25%",
    attrLabelPair {
      label = "Strength",
      attribute = attributes.strength,
      character = props.character,
      value = characterAttributes[attributes.strength],
      editable = props.editable
    },
    attrLabelPair {
      label = "Agility",
      attribute = attributes.agility,
      character = props.character,
      value = characterAttributes[attributes.agility],
      editable = props.editable
    },
    attrLabelPair {
      label = "Endurance",
      attribute = attributes.endurance,
      character = props.character,
      value = characterAttributes[attributes.endurance],
      editable = props.editable
    },
    attrLabelPair {
      label = "Education",
      attribute = attributes.education,
      character = props.character,
      value = characterAttributes[attributes.education],
      editable = props.editable
    },
    attrLabelPair {
      label = "Wit",
      attribute = attributes.wit,
      character = props.character,
      value = characterAttributes[attributes.wit],
      editable = props.editable
    },
    attrLabelPair {
      label = "Social",
      attribute = attributes.social,
      character = props.character,
      value = characterAttributes[attributes.social],
      editable = props.editable
    },
  }
end)