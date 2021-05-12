-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local WorldMapDetails = require "game.ui.widgets.world_map_details"
local KeyboardMap = require "game.ui.inputs.keyboard_map"

local WorldMap = Components("world_map", function()
  return {
    id = "world_map",

    FullScreenPanel {
      title = "World Map",
      contents = {
        WorldMapDetails()
      }
    },

    keyboardMap = function(self)
      return {
        [","] = self.viewLevelDown,
        ["."] = self.viewLevelUp,
        ["tab"] = self.closeScreen,
      }
    end,

    closeScreen = function()
      local App = require "game.app"
      App.combat()
    end,

    mounted = function(self)
      KeyboardMap.setMapping(self:keyboardMap())
    end,

    unmounted = function(self)
      KeyboardMap.removeMapping(self:keyboardMap())
    end
  }
end)


return WorldMap