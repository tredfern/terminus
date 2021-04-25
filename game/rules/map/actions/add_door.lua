-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addEntity = require "game.rules.world.actions.add_entity"
local doors = require "assets.maps.features.doors"

return function(position, orientation)
  local entity = {
    sprite = doors[orientation].closed,
    position = position,
    door = true,
    closed = true,
    orientation = orientation
  }

  return addEntity(entity)
end