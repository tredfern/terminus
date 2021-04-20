-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ladders = require "data.features.ladders"
local World = require "game.rules.world"

return function(position)
  local ladder = {
    position = position,
    sprite = ladders.up
  }
  return World.actions.addEntity(ladder)
end