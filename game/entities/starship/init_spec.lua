-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.starship", function()
  local starship = require "game.entities.starship"

  it("starships can have weapons equipped", function()
    local s = starship.new()
    s:attach_weapon(starship.weapons.laser_cannon)
  end)
end)