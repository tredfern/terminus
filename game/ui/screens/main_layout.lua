-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local panel = require "game.ui.widgets.panel"
return moonpie.ui.components("main_layout", function()
  local title = require "game.ui.widgets.location_title"
  local game_view = require "game.ui.widgets.game_view"
  local message_log = require "game.ui.widgets.message_log"
  local player_panel = require "game.ui.widgets.player_panel"

  return {
    title(),
    player_panel(),
    {
      style = "game_panel",
      game_view(),
      panel {
        title = "Message Log",
        contents = message_log()
      }
    }
  }
end)