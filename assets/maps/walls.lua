-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ImageManager = require "game.rules.graphics.image_manager"

local filename = "assets/maps/spaceship-walls.png"

local wallSprite = { }
wallSprite.se = ImageManager.load("SPACESHIP_WALL_SE", filename, { 0, 0, 32, 32 })
wallSprite.nsew = ImageManager.load("SPACESHIP_WALL_NSEW", filename, { 32, 0, 32, 32 })
wallSprite.ew = ImageManager.load("SPACESHIP_WALL_EW", filename, { 64, 0, 32, 32 })
wallSprite.sw = ImageManager.load("SPACESHIP_WALL_SW", filename, { 96, 0, 32, 32 })
wallSprite.nse = ImageManager.load("SPACESHIP_WALL_NSE", filename, { 0, 32, 32, 32 })
wallSprite.w = ImageManager.load("SPACESHIP_WALL_W", filename, { 32, 32, 32, 32 })
wallSprite.e = ImageManager.load("SPACESHIP_WALL_E", filename, { 64, 32, 32, 32 })
wallSprite.nsw = ImageManager.load("SPACESHIP_WALL_NSW", filename, { 96, 32, 32, 32 })
wallSprite.ns = ImageManager.load("SPACESHIP_WALL_NS", filename, { 0, 64, 32, 32 })
wallSprite.s = ImageManager.load("SPACESHIP_WALL_S", filename, { 32, 64, 32, 32 })
wallSprite.sew = ImageManager.load("SPACESHIP_WALL_SEW", filename, { 64, 64, 32, 32 })
wallSprite.ne = ImageManager.load("SPACESHIP_WALL_NE", filename, { 0, 96, 32, 32 })
wallSprite.new = ImageManager.load("SPACESHIP_WALL_NEW", filename, { 32, 96, 32, 32 })
wallSprite.n = ImageManager.load("SPACESHIP_WALL_N", filename, { 64, 96, 32, 32 })
wallSprite.nw = ImageManager.load("SPACESHIP_WALL_NW", filename, { 96, 96, 32, 32 })

return wallSprite