-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local player_stats = require "game.ui.widgets.player_stats"
local cargo_hold = require "game.ui.widgets.cargo_hold"

return components("player_panel", function()
  return {
      components.h3 { text = "Player" },
      components.hr(),
      {
        style = "panel",
        player_stats(),
        cargo_hold(),
      }
  }
end)