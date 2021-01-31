-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"

return components("panel", function(props)
  return {
    drawComponent = function(self)
      local w, h = self.box.backgroundPosition.width, self.box.backgroundPosition.height
      local curve = 16
      love.graphics.setColor(colors(self.borderColor))
      love.graphics.rectangle("fill", 0, 0, w, h, curve, curve)
    end,
    components.text { id = "panel_title", text = props.title, style = "panel_title" },
    {
      id = "panel_contents",
      style = "panel_contents",
      props.contents
    }
  }
end)