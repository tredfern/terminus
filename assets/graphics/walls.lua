-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local imageMgr = require "moonpie.graphics.image"
local Sprite = require "game.graphics.sprite"

local wallAtlas = imageMgr.load("assets/graphics/placeholder-walls.png")

local wallSprite = { }
wallSprite.se = Sprite.fromAtlas(wallAtlas, 0, 0, 32, 32)
wallSprite.nsew = Sprite.fromAtlas(wallAtlas, 32, 0, 32, 32)
wallSprite.ew = Sprite.fromAtlas(wallAtlas, 64, 0, 32, 32)
wallSprite.sw = Sprite.fromAtlas(wallAtlas, 96, 0, 32, 32)
wallSprite.nse = Sprite.fromAtlas(wallAtlas, 0, 32, 32, 32)
wallSprite.w = Sprite.fromAtlas(wallAtlas, 32, 32, 32, 32)
wallSprite.e = Sprite.fromAtlas(wallAtlas, 64, 32, 32, 32)
wallSprite.nsw = Sprite.fromAtlas(wallAtlas, 96, 32, 32, 32)
wallSprite.ns = Sprite.fromAtlas(wallAtlas, 0, 64, 32, 32)
wallSprite.s = Sprite.fromAtlas(wallAtlas, 32, 64, 32, 32)
wallSprite.sew = Sprite.fromAtlas(wallAtlas, 64, 64, 32, 32)
wallSprite.ne = Sprite.fromAtlas(wallAtlas, 0, 96, 32, 32)
wallSprite.new = Sprite.fromAtlas(wallAtlas, 32, 96, 32, 32)
wallSprite.n = Sprite.fromAtlas(wallAtlas, 64, 96, 32, 32)
wallSprite.nw = Sprite.fromAtlas(wallAtlas, 96, 96, 32, 32)

return wallSprite