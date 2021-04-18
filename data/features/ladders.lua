-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Sprite = require "game.rules.graphics.sprite"
local ImageMgr = require "moonpie.graphics.image"

local ladderAtlas = ImageMgr.load("data/features/ladders.png")
return {
  down = Sprite.fromAtlas(ladderAtlas, 0, 0, 32, 32),
  up = Sprite.fromAtlas(ladderAtlas, 32, 0, 32, 32)
}