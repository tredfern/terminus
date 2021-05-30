-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.equip_slots", function()
  local equipSlots = require "game.rules.inventory.equip_slots"

  it("defines slots for equipping items", function()
    assert.not_nil(equipSlots.MELEE)
  end)
end)