-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ImageManager = require "game.rules.graphics.image_manager"
local Settings = require "game.settings"

local filename = Settings.assetPath("maps/features/ladders.png")

return {
  down = ImageManager.load("LADDER_DOWN", filename, { 0, 0, 32, 32 }),
  up = ImageManager.load("LADDER_UP", filename, { 32, 0, 32, 32 })
}