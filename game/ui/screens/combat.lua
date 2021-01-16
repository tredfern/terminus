-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require 'moonpie.ui.components'
local map_component = require "game.ui.widgets.combat_map"
local keyboard_map = require 'game.ui.inputs.keyboard_map'
local turn_counter = require "game.ui.widgets.turn_counter"
local character_stats = require "game.ui.widgets.character_stats"
local colors = require "moonpie.graphics.colors"

local combat_screen = components("combat_screen", function()
  return {
    id = "combat_screen",
    {
      style = "main_screen",
      map_component(),
    }, {
      style = "stats",
      background_color = colors.black,
      components.h3 { text = "Stats" },
      {
        style = "stats_content",
        turn_counter(),
        character_stats()
      }
    },

    mounted = function()
      keyboard_map.enable_combat_map()
    end,

    unmounted = function()
      keyboard_map.disable_combat_map()
    end
  }
end)

return combat_screen