-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local player_stats = require "game.ui.widgets.player_stats"
local cargo_hold = require "game.ui.widgets.cargo_hold"

return components("player_panel", function()
  return {
    panel {
      title = "Player",
      contents = {
        player_stats(),
        cargo_hold()
      }
    }
  }
end)