-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.weapons", function()
  local Weapons = require "game.rules.items.weapons"
  local Characters = require "game.rules.character"

  it("defines a sword", function()
    local s = Weapons.sword()
    assert.equals("sword", s.key)
    assert.equals("Sword", s.name)
    assert.equals("1d6", s.damage)
    assert.equals(Characters.equipSlots.melee, s.equipSlot)
  end)
end)