-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require 'moonpie.ui.components'
local map_component = require "game.ui.widgets.combat_map"
local keyboard_map = require 'game.ui.inputs.keyboard_map'
local turn_counter = require "game.ui.widgets.turn_counter"
local character_stats = require "game.ui.widgets.character_stats"
local message_log = require "game.ui.main_screen.message_log"
local scoreboard = require "game.ui.widgets.scoreboard"

local mainScreen = components("main_screen", function()
  return {
    id = "main_screen",
    {
      style = "map_view",
      map_component(),
      message_log(),
    }, {
      style = "stats",
      components.h3 { text = "Stats" },
      {
        style = "stats_content",
        turn_counter(),
        character_stats(),
        scoreboard()
      },
    },

    mounted = function()
      keyboard_map.enableCombatMap()
    end,

    unmounted = function()
      keyboard_map.disableCombatMap()
    end
  }
end)

return mainScreen