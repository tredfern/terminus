-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_equipment", function()
  local CharacterEquipment = require "game.ui.widgets.character_equipment"
  local equipSlots = require "game.rules.inventory.equip_slots"

  it("shows the items for a character that are equipped", function()
    local meleeItem = { name = "Baton" }
    local equipped = {
      [equipSlots.MELEE] = meleeItem
    }

    local widget = CharacterEquipment { equipped = equipped }

    assert.equals("Baton", widget:findByID("meleeItemValue").text)

  end)
end)