-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require 'moonpie.ui.components'
local map_component = require "game.ui.widgets.combat_map"

local combat_screen = components("combat_screen", function()
  return {
    id = "combat_screen",
    components.h2 { text = "COMBAT!!!" },
    map_component()



  }
end)


return combat_screen