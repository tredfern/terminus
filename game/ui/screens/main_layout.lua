-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("main_layout", function()
  local title = require "game.ui.widgets.location_title"
  local travel_menu = require "game.ui.widgets.space_travel_menu"
  local cargo_hold = require "game.ui.widgets.cargo_hold"
  local market = require "game.ui.widgets.market"

  return {
    title(),
    moonpie.ui.components.hr(),
    {
      moonpie.ui.components.h3 { text = "Market" },
      market()
    },
    {
      moonpie.ui.components.h3 { text = "Cargo Hold" },
      cargo_hold()
    },
    {
      moonpie.ui.components.h3 { text = "Destinations" },
      travel_menu()
    }
  }
end)