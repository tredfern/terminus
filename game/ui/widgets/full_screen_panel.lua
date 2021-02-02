-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Colors = require "moonpie.graphics.colors"

return Components("full_screen_panel", function(props)
  return {
    drawComponent = function(self)
      local w, h = self.box.backgroundPosition.width, self.box.backgroundPosition.height
      local curve = 16
      love.graphics.setColor(Colors(self.borderColor))
      love.graphics.rectangle("fill", 0, 0, w, h, curve, curve)
    end,
    Components.text { text = props.title, id = "full_screen_panel_title", style = "full_screen_panel_title" },
    {
      id = "full_screen_panel_contents",
      style = "full_screen_panel_contents",
      props.contents
    }
  }
end)