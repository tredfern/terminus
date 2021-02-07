-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local store = require "moonpie.redux.store"
local connect = require "moonpie.redux.connect"
local app = require "game.app"
local character = require "game.rules.character"
local fullScreenPanel = require "game.ui.widgets.full_screen_panel"
local characterAttributes = require "game.ui.widgets.character_attributes"
local characterSkills = require "game.ui.widgets.character_skills"

local create_character = components("create_character", function(props)

  local editCharacter = props.character
  local character_name = components.textbox {
    id = "character_name",
    click = function(self) self:set_focus() end,
    width = "100%",
  }
  character_name:set_text("Papageno")

  return {
    id = "create_character_screen",
    fullScreenPanel {
      title = "Create Character",
      contents = {
        padding = 6,
        {
          components.h3 { text = "Name"},
          character_name,
        },
        {
          { components.h3 { text = "Attributes"} },
          characterAttributes { id = "characterAttributes", character = editCharacter }
        },
        {
          { components.h3 { text = "Skills" } },
          characterSkills { id = "characterSkills", character = editCharacter }
        },
        {
          margin = 4,
          components.button {
            id = "button_done",
            caption = "Done",
            style = "align-right",
            click = function()
              store.dispatch(character.actions.setName(
                editCharacter,
                character_name:get_text()
              ))
              app.combat()
            end
          },
        },
      }
    },
    mounted = function()
      character_name:setFocus()
    end
  }
end)

return connect(create_character, function(state)
  return {
    character = character.selectors.getPlayer(state)
  }
end)