-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local animation = require "game.rules.graphics.animation"
local Settings = require "game.settings"
local ImageManager = require "game.rules.graphics.image_manager"
local fileName = Settings.assetPath("characters/character_idle.png")

ImageManager.load("CHARACTER_IDLE_FRAME_1", fileName, { 0, 0, 32, 32 })
ImageManager.load("CHARACTER_IDLE_FRAME_2", fileName, { 32, 0, 32, 32 })
ImageManager.load("CHARACTER_IDLE_FRAME_3", fileName, { 64, 0, 32, 32 })
ImageManager.load("CHARACTER_IDLE_FRAME_4", fileName, { 96, 0, 32, 32 })

local character_idle = animation:new()
character_idle:addFrame(ImageManager.getDrawable("CHARACTER_IDLE_FRAME_1"), 0.3)
character_idle:addFrame(ImageManager.getDrawable("CHARACTER_IDLE_FRAME_2"), 0.3)
character_idle:addFrame(ImageManager.getDrawable("CHARACTER_IDLE_FRAME_3"), 0.3)
character_idle:addFrame(ImageManager.getDrawable("CHARACTER_IDLE_FRAME_4"), 0.3)

return character_idle