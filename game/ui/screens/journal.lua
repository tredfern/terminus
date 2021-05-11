-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local Keyboard = require "moonpie.keyboard"
local App = require "game.app"

local Journal = Components("journal_screen", function()
  return {
    id = "journal_screen",
    FullScreenPanel {
      title = "Journal"
    },

    mounted = function()
      Keyboard:hotkey("j", App.combat)
    end,

    unmounted = function()
      Keyboard:hotkey("j", nil)
    end
  }
end)

return connect(
  Journal,
  function()
    return {

    }
  end)