-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

return {
  blank = {
    color = colors.oxford_blue,
    blocks_movement = true
  },
  boundary = {
    color = colors.gray
  },
  corridor = {
    color = colors.beaver
  },
  dirt = {
    color = colors.lighten(colors.beaver, 0.8)
  },
  door = {
    color = colors.green
  },
  grass = {
    color = colors.lighten(colors.pakistan_green, 1.2)
  },
  room = {
    color = colors.bronze
  },
  water = {
    color = colors.lighten(colors.oxford_blue, 2.2)
  }
}