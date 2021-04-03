-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addEntity = require "game.rules.world.actions.add_entity"
local sprite = require "game.graphics.sprite"

return function(x, y)
  return addEntity {
    x = x,
    y = y,
    spawner = true,
    sprite = sprite.fromFile("assets/graphics/spawner.png")
  }
end