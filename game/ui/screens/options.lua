-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"

local OptionsScreen = Components("options_screen", function(props)
  return {
    id = "options_screen",
    FullScreenPanel {
      title = "Options",
      contents = {
        Components.button { id = "close_button", caption = "Close", click = props.returnScreen }
      }
    }
  }
end)

return OptionsScreen