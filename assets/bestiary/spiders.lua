-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Settings = require "game.settings"
local ImageManager = require "game.rules.graphics.image_manager"

-- Image Definitions
ImageManager.load("SPIDER_CRAWLER", Settings.assetPath("graphics/bestiary/spiders/crawler.png"))

return {
  crawler = {
    strength = "2d6+3",
    dexterity = "3d4+4",
    endurance = "1d6+6",
    intelligence = 2,
    knowledge = 2,
    charisma = 2,
    sprite = ImageManager.getDrawable("SPIDER_CRAWLER"),
    health = "1d10+2"
  }
}