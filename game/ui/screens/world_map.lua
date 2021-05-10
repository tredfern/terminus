-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Keyboard = require "moonpie.keyboard"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local WorldMapDetails = require "game.ui.widgets.world_map_details"

local WorldMap = Components("world_map", function()
  return {
    id = "world_map",

    FullScreenPanel {
      title = "World Map",
      contents = {
        WorldMapDetails()
      }
    },

    mounted = function()
      local App = require "game.app"
      Keyboard:hotkey("tab", App.combat)
      Keyboard:hotkey("m", App.combat)
    end,

    unmounted = function()
      Keyboard:hotkey("tab", nil)
      Keyboard:hotkey("m", nil)
    end
  }
end)


return WorldMap