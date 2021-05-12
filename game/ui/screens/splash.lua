-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Keyboard = require "moonpie.keyboard"

local Splash = Components("splash", function()
  return {
    id = "splash_screen",
    {
      Components.image { source = "assets/long-logo.png", style = "align-center" },
      Components.h1 { text = "Short Leg Studio", style = "align-center logo_text" },
      Components.h3 { text = "Life is short, make it fun", style = "align-center logo_text" },
      style = "align-middle"
    },

    click = function()
      local App = require "game.app"
      App.title()
    end,

    mounted = function()
      Keyboard:hotkey("any", function()
        local App = require "game.app"
        App.title()
      end)
    end,

    unmounted = function()
      Keyboard:hotkey("any", nil)
    end,
  }
end)

return Splash