-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Sprite = require "game.rules.graphics.sprite"
local ImageMgr = require "moonpie.graphics.image"
local Settings = require "game.settings"
local Animation = require "game.rules.graphics.animation"
local Orientation = require "game.rules.world.orientation"

local doorAtlas = ImageMgr.load(Settings.assetPath("maps/features/doors.png"))
local closed = Sprite.fromAtlas(doorAtlas, 0, 0, 32, 32)
local opening1 = Sprite.fromAtlas(doorAtlas, 32, 0, 32, 32)
local opening2 = Sprite.fromAtlas(doorAtlas, 0, 32, 32, 32)
local opened = Sprite.fromAtlas(doorAtlas, 32, 32, 32, 32)

local opening = Animation:new()
opening:addFrame(opening1, 0.2)
opening:addFrame(opening2, 0.2)
opening:addFrame(opened, 0.2)

local closedEW = Sprite.fromAtlas(doorAtlas, 64, 0, 32, 32)
local openingEW1 = Sprite.fromAtlas(doorAtlas, 96, 0, 32, 32)
local openingEW2 = Sprite.fromAtlas(doorAtlas, 64, 32, 32, 32)
local openedEW = Sprite.fromAtlas(doorAtlas, 96, 32, 32, 32)

local openingEW = Animation:new()
openingEW:addFrame(openingEW1, 0.2)
openingEW:addFrame(openingEW2, 0.2)
openingEW:addFrame(openedEW, 0.2)

return {
  [Orientation.northSouth] = {
    closed = closed,
    opening = opening,
    opened = opened
  },
  [Orientation.eastWest] = {
    closed = closedEW,
    opening = openingEW,
    opened = openedEW
  }
}