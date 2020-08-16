-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local panel = require "game.ui.widgets.panel"
local title = require "game.ui.widgets.location_title"
local game_view = require "game.ui.widgets.game_view"
local message_log = require "game.ui.widgets.message_log"

return moonpie.ui.components("main_layout", function()

  return {
    title(), {
      style = "sidebar",
      panel {
        style = "stretch_height",
        title = "Message Log",
        contents = message_log()
      },
    },
    {
      style = "primary",
      game_view(),
    }
  }
end)