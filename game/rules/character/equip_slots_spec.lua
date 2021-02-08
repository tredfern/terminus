-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.equip_slots", function()
  local equipSlots = require "game.rules.character.equip_slots"

  it("defines slots for equipping items", function()
    assert.not_nil(equipSlots.melee)
  end)
end)