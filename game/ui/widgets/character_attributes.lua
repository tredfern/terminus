-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local store = require "game.store"
local connect = require "moonpie.redux.connect"
local attributes = require "game.rules.character.attributes"

local labelPair = Components("characterAttributeLabelPair", function(props)
  return {
    character = props.character,
    attribute = props.attribute,
    value = props.value,
    editable = props.editable,
    label = props.label,

    render = function(self)
      local buttons = {
        display = "inline", padding = { right = 3 },
      }
      if props.editable then
        buttons[1] = Components.button {
          id = props.label .. "Increase",
          caption = "+", style = "button-small",
          click = function()
            store.dispatch(Character.actions.setAttribute(self.character, self.attribute, self.value + 1))
          end
        }
        buttons[2] = Components.button {
          id = props.label .. "Decrease",
          caption = "-",
          style = "button-small",
          click = function()
            store.dispatch(Character.actions.setAttribute(self.character, self.attribute, self.value - 1))
          end
        }
      end
      return {
        buttons,
        Components.text { text = self.label },
        Components.text { id = self.label .. "Stat", text = self.value, style ="align-right" },
      }
    end
  }
end)

labelPair = connect(
  labelPair,
  function(state, component)
    if component == nil then return {} end
    return {
      value = Character.selectors.getAttribute(state, component.character, component.attribute)
    }
  end
)

return Components("character_attributes", function(props)
  local characterAttributes = props.attributes or {}

  return {
    width = "15%",
    labelPair {
      label = "Strength",
      attribute = attributes.strength,
      character = props.character,
      value = characterAttributes[attributes.strength],
      editable = props.editable
    },
    labelPair {
      label = "Agility",
      attribute = attributes.agility,
      character = props.character,
      value = characterAttributes[attributes.agility],
      editable = props.editable
    },
    labelPair {
      label = "Endurance",
      attribute = attributes.endurance,
      character = props.character,
      value = characterAttributes[attributes.endurance],
      editable = props.editable
    },
    labelPair {
      label = "Education",
      attribute = attributes.education,
      character = props.character,
      value = characterAttributes[attributes.education],
      editable = props.editable
    },
    labelPair {
      label = "Wit",
      attribute = attributes.wit,
      character = props.character,
      value = characterAttributes[attributes.wit],
      editable = props.editable
    },
    labelPair {
      label = "Social",
      attribute = attributes.social,
      character = props.character,
      value = characterAttributes[attributes.social],
      editable = props.editable
    },
  }
end)