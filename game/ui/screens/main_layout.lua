-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("main_layout", function()
  local title = require "game.ui.widgets.location_title"
  local travel_menu = require "game.ui.widgets.space_travel_menu"
  local cargo_hold = require "game.ui.widgets.cargo_hold"
  local market = require "game.ui.widgets.market"
  local player_stats = require "game.ui.widgets.player_stats"
  local message_log = require "game.ui.widgets.message_log"

  return {
    title(),
    moonpie.ui.components.hr(),
    {
      style = "game_panel",
      {
        moonpie.ui.components.h3 { text = "Market" },
        moonpie.ui.components.hr(),
        {
          style = "panel",
          market()
        }
      },
      {
        moonpie.ui.components.h3 { text = "Destinations" },
        moonpie.ui.components.hr(),
        {
          style = "panel",
          travel_menu(),
        }
      },
      {
        moonpie.ui.components.h3 { text = "Message Log" },
        moonpie.ui.components.hr(),
        {
          style = "panel",
          message_log()
        }
      }
    },
    {
      style = "player_panel",
      moonpie.ui.components.h3 { text = "Player" },
      {
        style = "panel",
        player_stats(),
        cargo_hold(),
      }
    },
  }
end)