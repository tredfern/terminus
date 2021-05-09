-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Keyboard = require "moonpie.keyboard"

local WorldMap = Components("world_map", function()
  return {
    id = "world_map",

    mounted = function()
      local App = require "game.app"
      Keyboard:hotkey("tab", App.combat)
    end,

    unmounted = function()
      Keyboard:hotkey("tab", nil)
    end
  }
end)


return WorldMap