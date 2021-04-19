-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ladders = require "data.features.ladders"
local World = require "game.rules.world"
local Position = require "game.rules.world.position"

return function(x, y)
  local ladder = {
    position = Position.new(x, y),
    sprite = ladders.up
  }
  return World.actions.addEntity(ladder)
end