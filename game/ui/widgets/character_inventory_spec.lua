-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_inventory", function()
  local characterInventory = require "game.ui.widgets.character_inventory"
  local mockStore = require "test_helpers.mock_store"

  setup(function()
    mockStore({})
  end)

  it("shows the items from the character inventory", function()
    local widget = moonpie.test_render(characterInventory({
      inventory = {
        { item = { name = "Sword" }, quantity = 1 },
        { item = { name = "Health Pack" }, quantity = 3 }
      }
    }))

    local item1 = widget:findByID("inventoryItem1")
    local item2 = widget:findByID("inventoryItem2")

    assert.equals("Sword", item1.text)
    assert.equals("Health Pack", item2.text)
  end)

  it("adds a button to use an item if usable", function()
    local widget = moonpie.test_render(characterInventory {
      inventory = {
        { item = { name = "Health Kit", useHandler = function() end } }
      }
    })

    local item1UseButton = widget:findByID("inventoryItem1UseButton")
    assert.not_nil(item1UseButton)
  end)

  it("call the item use routine when use button is pushed", function()
    local Items = require "game.rules.items"
    spy.on(Items.actions, "use")

    local widget = moonpie.test_render(characterInventory {
      inventory = {
        { item = { name = "Health Kit", useHandler = function() end }, quantity = 1 }
      },
      character = {}
    }):findByID("characterInventory")

    local item1UseButton = widget:findByID("inventoryItem1UseButton")
    item1UseButton:click()

    assert.spy(Items.actions.use).was.called_with(widget.inventory[1].item, widget.character)
  end)
end)