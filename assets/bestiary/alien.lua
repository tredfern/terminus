-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local animation = require "game.rules.graphics.animation"
local Settings = require "game.settings"
local ImageManager = require "game.rules.graphics.image_manager"
local fileName = Settings.assetPath("bestiary/alien_idle.png")

ImageManager.load("ALIEN_IDLE_FRAME_1", fileName, { 0, 0, 32, 32 })
ImageManager.load("ALIEN_IDLE_FRAME_2", fileName, { 32, 0, 32, 32 })
ImageManager.load("ALIEN_IDLE_FRAME_3", fileName, { 64, 0, 32, 32 })
ImageManager.load("ALIEN_IDLE_FRAME_4", fileName, { 96, 0, 32, 32 })

local alienIdle = animation:new()
alienIdle:addFrame(ImageManager.getDrawable("ALIEN_IDLE_FRAME_1"), 0.3)
alienIdle:addFrame(ImageManager.getDrawable("ALIEN_IDLE_FRAME_2"), 0.3)
alienIdle:addFrame(ImageManager.getDrawable("ALIEN_IDLE_FRAME_3"), 0.3)
alienIdle:addFrame(ImageManager.getDrawable("ALIEN_IDLE_FRAME_4"), 0.3)

return alienIdle