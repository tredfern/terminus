-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local CharacterInventory = require "game.ui.widgets.character_inventory"
local CharacterEquipment = require "game.ui.widgets.character_equipment"
local Player = require "game.rules.player"

local Inventory = Components("inventory_screen", function(props)
  return {
    id = "inventory_screen",
    player = props.player,

    FullScreenPanel {
      title = "Inventory",
      contents = {
        {
          width = "50%",
          { Components.h3 { text = "Equipment" } },
          CharacterEquipment {
            id = "characterEquipment",
            equipSlots = props.player.inventory.equipSlots
          },
        }, {
          width = "50%",
          { Components.h3 { text = "Inventory" } },
          CharacterInventory {
            id = "characterInventory",
            inventory = props.player.inventory,
            character = props.player
          }
        }
      }
    },

    mounted = function()
      local Keys = require "moonpie.keyboard"
      local App = require "game.app"
      Keys:hotkey("i", App.combat)
    end,

    unmounted = function()
      local Keys = require "moonpie.keyboard"
      Keys:hotkey("i", nil)
    end
  }
end)

return connect(
  Inventory,
  function(state)
    return {
      player = Player.selectors.getPlayer(state)
    }
  end)