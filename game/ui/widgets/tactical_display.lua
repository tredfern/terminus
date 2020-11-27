-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local colors = require "moonpie.graphics.colors"

local tactical_display = components("tactical_display", function()
  return {
    draw_component = function(self)
      local w, h = self.box:width(), self.box:height()
      love.graphics.setColor(colors.red)

      love.graphics.rectangle("line", 0, 0, w, h)
    end

  }
end)

return tactical_display