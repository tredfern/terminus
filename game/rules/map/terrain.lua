-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

return {
  blank = {
    color = colors.oxford_blue,
    blocks_movement = true,
    noImage = true,
  },
  boundary = {
    color = colors.gray
  },
  corridor = {
    color = colors(colors.light_accent)
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
    color = colors.white
  },
  wall = {
    type = "wall",
    color = colors.white,
    blocks_movement = true,
  },
  water = {
    color = colors.lighten(colors.oxford_blue, 2.2)
  }
}