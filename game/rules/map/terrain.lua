-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

return {
  dirt = {
    color = colors.lighten(colors.beaver, 0.8)
  },
  grass = {
    color = colors.lighten(colors.pakistan_green, 1.2)
  },
  water = {
    color = colors.lighten(colors.oxford_blue, 2.2)
  }
}