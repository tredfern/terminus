-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local starship = require "game.entities.starship"
local cargo_hold = require "game.entities.starship.cargo_hold"

return function(game)
  local p = starship:new {
    cargo_hold = cargo_hold:new { size = 15 }
  }
  game.player = p
end