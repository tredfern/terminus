-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local animation = require "game.rules.graphics.animation"
local sprite = require "game.rules.graphics.sprite"
local imageMgr = require "moonpie.graphics.image"

local imageData = imageMgr.load("data/characters/character_idle.png")
local frame1 = sprite.fromAtlas(imageData, 0, 0, 32, 32)
local frame2 = sprite.fromAtlas(imageData, 32, 0, 32, 32)
local frame3 = sprite.fromAtlas(imageData, 64, 0, 32, 32)
local frame4 = sprite.fromAtlas(imageData, 96, 0, 32, 32)

local character_idle = animation:new()
character_idle:addFrame(frame1, 0.3)
character_idle:addFrame(frame2, 0.3)
character_idle:addFrame(frame3, 0.3)
character_idle:addFrame(frame4, 0.3)

return character_idle