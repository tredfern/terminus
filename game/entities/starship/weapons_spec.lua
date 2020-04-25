-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.starship.weapons", function()
  local weapons = require "game.entities.starship.weapons"

  it("it can register a weapon that can be instantiated", function()
    weapons.register("super_blaster_cannon", {
      name = "Super Blaster"
    })
    local new = weapons.super_blaster_cannon()
    assert.equals("Super Blaster", new.name)
  end)
end)