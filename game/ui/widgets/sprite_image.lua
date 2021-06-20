-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

return Components("sprite_image", function(props)
  return {
    sprite = props.sprite,
    drawComponent = function(self)
      self.sprite:draw(0, 0)
    end
  }
end)