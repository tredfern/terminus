-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local connect = require "moonpie.redux.connect"
local Panel = require "game.ui.widgets.panel"
local store = require "game.store"

local BasicInformation = Components("createCharacterBasicInformation", function(props)
  local updateName = function(textBox)
    store.dispatch(Character.actions.setName(props.character, textBox:getText()))
  end

  return {
    character = props.character,
    id = "basicInformation",
    Panel {
      title = "Name",
      contents = {
        Components.h3 { text = "Name" },
        Components.textbox {
          id = "characterName",
          click = function(self) self:setFocus() end,
          width = "80%",
          onUpdate = updateName
        },
      }
    },
    Panel {
      title = "Attributes",
      contents = {
        Components.h3 { text = "Attributes" },
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