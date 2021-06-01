-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local store = require "moonpie.redux.store"
local connect = require "moonpie.redux.connect"
local app = require "game.app"
local character = require "game.rules.character"
local player = require "game.rules.player"
local Skills = require "game.rules.skills"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local CharacterAttributes = require "game.ui.widgets.character_attributes"
local CharacterSkills = require "game.ui.widgets.character_skills"
local LabelPair = require "game.ui.widgets.label_pair"

local create_character = components("create_character", function(props)
  local editCharacter = props.character
  local character_name = components.textbox {
    id = "character_name",
    click = function(self) self:setFocus() end,
    width = "100%",
  }
  character_name:setText(props.character.name)

  return {
    id = "create_character_screen",
    FullScreenPanel {
      title = "Create Character",
      actions = {
        components.button {
          id = "button_done",
          caption = "Done",
          style = "button-primary",
          click = function()
            store.dispatch(character.actions.setName(
              editCharacter,
              character_name:getText()
            ))
            app.gameStart()
          end
        },
      },
      contents = {
        padding = 6,
        {
          components.h3 { text = "Name"},
          character_name,
        },
        {
          { components.h3 { text = "Attributes"} },
          CharacterAttributes {
            id = "characterAttributes", attributes = editCharacter.attributes,
            editable = true, character = editCharacter
          },
          LabelPair {
            margin = { left = 10 },
            width = "15%",
            label = "Health:",
            value = editCharacter.health
          }
        },
        {
          { components.h3 { text = "Skills" } },
          CharacterSkills { id = "characterSkills",
            characterSkills = props.characterSkills
          }
        },
      }
    },
    mounted = function()
      character_name:setFocus()
    end
  }
end)

return connect(create_character, function(state)
  local p = player.selectors.getPlayer(state)
  return {
    character = p,
    characterSkills = Skills.selectors.getCharacterSkills(state, p)
  }
end)