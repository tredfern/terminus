-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("main_layout", function()
  local title = require "game.ui.widgets.location_title"
  local travel_menu = require "game.ui.widgets.space_travel_menu"
  return {
    title(),
    moonpie.ui.components.hr(),
    {
      moonpie.ui.components.h3 { text = "Destinations" },
      travel_menu()
    }
  }
end)