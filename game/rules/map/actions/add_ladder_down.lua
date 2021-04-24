-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ladders = require "assets.maps.features.ladders"
local World = require "game.rules.world"

return function(position)
  local ladder = {
    position = position,
    sprite = ladders.down,
    ladderDown = true
  }
  return World.actions.addEntity(ladder)
end