-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"


return components("section_title", function(props)
  return {
    draw_component = function(self)
      local w, h = self.box:background_size()
      local curve = h / 2
      love.graphics.setColor(colors(self.color))
      love.graphics.rectangle("fill", 0, 0, w, h, curve, curve)
    end,
    components.text {
      text = props.title,
      id = "section_title",
      style = "section_title_text"
    }
  }

end)