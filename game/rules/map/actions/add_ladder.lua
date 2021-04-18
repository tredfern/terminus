-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ladders = require "data.features.ladders"
local World = require "game.rules.world"

return function(x, y)
  local ladder = {
    x = x,
    y = y,
    sprite = ladders.up
  }
  return World.actions.addEntity(ladder)
end