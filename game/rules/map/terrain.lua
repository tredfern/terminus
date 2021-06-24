-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"
local ImageManager = require "game.rules.graphics.image_manager"

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
  ImageManager.load("CORRIDOR_1", "assets/maps/floor-1.png"),
  ImageManager.load("CORRIDOR_2", "assets/maps/floor-2.png")
} }

--
-- ROOM
--
Terrain.describe { key = "room", color = colors.white, images = {
  ImageManager.load("FLOOR_1", "assets/maps/floor-1.png"),
  ImageManager.load("FLOOR_2", "assets/maps/floor-2.png")
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
  sprite = require "assets.maps.walls"
}

return Terrain