-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local connect = require "moonpie.redux.connect"
local store = require "game.store"

local function AttributeComp(attribute, icon, score, modifier)
  return {
    style = "attribute",
    {
      Components.icon { icon = icon, style = "icon-medium attribute-icon", padding = 4,
        border = 1, borderColor = "light_accent", backgroundColor = "dark_accent" },
      Components.text { text = attribute, style = "attribute-title align-middle" },
      Components.text { text = "{{score}} ({{modifier}})",
        score = score, modifier = modifier, style = "attribute-score align-middle" }
    },
  }
end

local BasicInformation = Components("createCharacterBasicInformation", function(props)
  local updateName = function(textBox)
    store.dispatch(Character.actions.setName(props.character, textBox:getText()))
  end

  return {
    character = props.character,
    id = "basicInformation",
    {
      Components.h3 { text = "Name" },
      Components.textbox {
        id = "characterName",
        click = function(self) self:setFocus() end,
        width = "80%",
        onUpdate = updateName
      },
    }, {
      Components.h3 { text = "Attributes" },
      {
        {
          AttributeComp("Strength", "strong", 12, 2),
          AttributeComp("Dexterity", "acrobatic", 12, 2),
          AttributeComp("Endurance", "jumping-rope", 12, 2),
        },
        {
          AttributeComp("Knowledge", "diploma", 12, 2),
          AttributeComp("Intelligence", "brain", 12, 2),
          AttributeComp("Charisma", "star-struck", 12, 2),
        }
      }
    }
  }
end)

return connect(BasicInformation, function(state, props)
  return {
    characterName = Character.selectors.getName(state, props.character),
    attributes = Character.selectors.getAttributes(state, props.character)
  }
end)