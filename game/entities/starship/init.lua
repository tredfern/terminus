-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local starship = moonpie.class({})

function starship:attach_weapon()
end


return {
  new = function()
    return starship:new()
  end,
  weapons = require "game.entities.starship.weapons"
}