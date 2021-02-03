-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local VideoResolution = require "game.ui.widgets.video_resolution"

local OptionsScreen = Components("options_screen", function(props)
  local videoResolution = VideoResolution { id = "videoResolution" }
  return {
    id = "options_screen",
    FullScreenPanel {
      title = "Options",
      contents = {
        Components.text { text = "Screen Resolution: "},
        videoResolution,
        Components.button {
          id = "btnApply",
          caption = "Apply",
          click = function()
            local res = videoResolution:getResolution()
            love.window.setMode(res.width, res.height)
            moonpie.resize(res.width, res.height)
          end
        },
        Components.button { id = "btnClose", caption = "Close", click = props.returnScreen },
      }
    }
  }
end)

return OptionsScreen