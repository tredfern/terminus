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
local Keyboard = require "moonpie.keyboard"

local CharacterDetails = Components("character_details", function(props)
  local app = require "game.app"

  return {
    id = "character_details_screen",

    FullScreenPanel {
      id = "screenPanel",
      title = props.characterName,
      contents = {
        {
          { Components.h3 { text = "Attributes" } },
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
            equipSlots = props.character.inventory.equipSlots
          },
        },
        {
          Components.h3 { text = "Inventory" },
          {
            CharacterInventory {
              id = "characterInventory",
              inventory = props.character.inventory,
              character = props.character
            },
          }
        },
        Components.button { id = "btnClose", caption = "Close", click = app.combat }
      }
    },

    mounted = function()
      Keyboard:hotkey("tab", app.combat)
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
      characterName = player.name
    }
  end
)