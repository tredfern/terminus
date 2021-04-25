-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addEntity = require "game.rules.world.actions.add_entity"
local doors = require "assets.maps.features.doors"
local Animator = require "game.rules.graphics.animator"

return function(position, orientation)
  local a = Animator:new()
  a:addAnimation("opening", doors[orientation].opening)
  local entity = {
    sprite = doors[orientation].closed,
    position = position,
    door = true,
    closed = true,
    orientation = orientation,
    animator = a
  }

  return addEntity(entity)
end