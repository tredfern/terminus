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
      onUpdate = function(component)
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
    attrLabelPair {
      label = "Strength",
      attribute = attributes.strength,
      character = props.character,
      value = characterAttributes[attributes.strength],
      editable = props.editable
    },
    attrLabelPair {
      label = "Dexterity",
      attribute = attributes.dexterity,
      character = props.character,
      value = characterAttributes[attributes.dexterity],
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
      label = "Knowledge",
      attribute = attributes.knowledge,
      character = props.character,
      value = characterAttributes[attributes.knowledge],
      editable = props.editable
    },
    attrLabelPair {
      label = "Intelligence",
      attribute = attributes.intelligence,
      character = props.character,
      value = characterAttributes[attributes.intelligence],
      editable = props.editable
    },
    attrLabelPair {
      label = "Charisma",
      attribute = attributes.charisma,
      character = props.character,
      value = characterAttributes[attributes.charisma],
      editable = props.editable
    },
  }
end)