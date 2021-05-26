-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"
local imageMgr = require "moonpie.graphics.image"

local Terrain = {
  list = {}
}

function Terrain.describe(props)
  Terrain.list[props.key] = props
end

Terrain.describe {
  key = "blank",
  color = colors.oxford_blue,
  noImage = true,
  blocksMovement = true
}

Terrain.describe { key = "corridor", color = colors(colors.light_accent), images = {
  imageMgr.load("assets/graphics/floor-1.png"),
  imageMgr.load("assets/graphics/floor-2.png")
} }

--
-- ROOM
--
Terrain.describe { key = "room", color = colors.white, images = {
  imageMgr.load("assets/graphics/floor-1.png"),
  imageMgr.load("assets/graphics/floor-2.png")
} }

--
-- WALL
--
Terrain.describe {
  key = "wall",
  color = colors.white,
  blocksMovement = true,
  blocksSight = true,
  type = "wall",
  sprite = require "assets.graphics.walls"
}

return Terrain