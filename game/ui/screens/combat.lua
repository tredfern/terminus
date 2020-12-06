-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require 'moonpie.ui.components'

local combat_screen = function()
  return {
    id = "combat_screen",
    components.h2 { text = "COMBAT!!!" }


  }
end


return combat_screen