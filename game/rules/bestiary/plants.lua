-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ImageManager = require "game.rules.graphics.image_manager"
local Settings = require "game.settings"

local Plants = {}

function Plants.prickleBush()
  local fileName = Settings.assetPath("bestiary/plants/pricklybush.png")
  ImageManager.load("PRICKLE_BUSH", fileName)
  return {
    immobile = true,
    blocksMovement = true,
    blocksSight = true,
    sprite = ImageManager.getDrawable("PRICKLE_BUSH")
  }
end

return Plants