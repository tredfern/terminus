-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_inventory", function()
  local characterInventory = require "game.ui.widgets.character_inventory"

  it("shows the items from the character inventory", function()
    local widget = characterInventory({
      inventory = {
        { name = "Sword" },
        { name = "Health Pack" }
      }
    })

    local item1 = widget:findByID("inventoryItem1")
    local item2 = widget:findByID("inventoryItem2")

    assert.equals("Sword", item1.text)
    assert.equals("Health Pack", item2.text)
  end)

  it("adds a button to use an item if usable", function()
    local widget = characterInventory {
      inventory = {
        { name = "Health Kit", usable = true }
      }
    }

    local item1UseButton = widget:findByID("inventoryItem1UseButton")
    assert.not_nil(item1UseButton)
  end)
end)