-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_equipment", function()
  local CharacterEquipment = require "game.ui.widgets.character_equipment"

  it("shows the items for a character that are equipped", function()
    local meleeItem = { name = "Baton" }
    local equipSlots = {
      melee = meleeItem
    }

    local widget = CharacterEquipment { equipSlots = equipSlots }

    assert.equals("Baton", widget:findByID("meleeItem").text)

  end)
end)