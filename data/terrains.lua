-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Terrain = require "game.rules.map.terrain"
local colors = require "moonpie.graphics.colors"
local imageMgr = require "moonpie.graphics.image"

Terrain.describe { key = "corridor", color = colors(colors.light_accent), images = {
  imageMgr.load("assets/graphics/floor-1.png"),
  imageMgr.load("assets/graphics/floor-2.png")
} }
Terrain.describe { key = "room", color = colors.white, images = {
  imageMgr.load("assets/graphics/floor-1.png"),
  imageMgr.load("assets/graphics/floor-2.png")
} }
Terrain.describe { key = "wall", color = colors.white, blocksMovement = true, type = "wall",
  sprite = require "assets.graphics.walls"
}