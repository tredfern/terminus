-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"

local inventory = Components("inventory_screen", function()
  return {
    id = "inventory_screen",
    FullScreenPanel {
      title = "Inventory",
      contents = {
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

return inventory