-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local CharacterAttributes = require "game.ui.widgets.character_attributes"
local CharacterSkills = require "game.ui.widgets.character_skills"
local CharacterInventory = require "game.ui.widgets.character_inventory"
local CharacterEquipment = require "game.ui.widgets.character_equipment"
local Player = require "game.rules.player"
local Inventory = require "game.rules.inventory"
local Keyboard = require "moonpie.keyboard"

local CharacterDetails = Components("character_details", function(props)
  local app = require "game.app"

  return {
    id = "character_details_screen",

    FullScreenPanel {
      id = "screenPanel",
      title = props.characterName,
      actions = {
        Components.button { id = "btnClose", caption = "Close", click = app.mainScreen }
      },
      contents = {
        {
          style = "character-details-panel",
          { Components.h3 { text = "Attributes" }, style = "character-details-panel-title" },
          CharacterAttributes { attributes = props.character.attributes, character = props.character }
        },
        {
          { Components.h3 { text = "Skills" } },
          CharacterSkills { character = props.character }
        },
        {
          { Components.h3 { text = "Equipped" } },
          CharacterEquipment {
            id = "characterEquipment",
            equipped = props.inventory.equipped
          },
        },
        {
          Components.h3 { text = "Inventory" },
          {
            CharacterInventory {
              id = "characterInventory",
              inventory = props.inventory.carried,
              character = props.character
            },
          }
        },
      }
    },

    mounted = function()
      Keyboard:hotkey("tab", app.mainScreen)
    end,

    unmounted = function()
      Keyboard:hotkey("tab", nil)
    end

  }
end)

return connect(
  CharacterDetails,
  function(state)
    local player = Player.selectors.getPlayer(state)
    return {
      character = player,
      characterName = player.name,
      inventory = Inventory.selectors.getInventory(state, player),
    }
  end
)