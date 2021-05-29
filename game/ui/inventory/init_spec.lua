-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inventory", function()
  local Inventory = require "game.ui.inventory"
  local TestStates = require "test_helpers.test_states"

  before_each(function()
    TestStates.basicGameState()
  end)

  it("renders a valid component", function()
    local inv = Inventory()
    assert.is_table(inv)
    assert.equals("inventory_screen", inv.id)
  end)

  it("returns to the main screen if the i key is pressed", function()
    local App = require "game.app"
    spy.on(App, "combat")
    moonpie.testRender(Inventory())

    local keys = require "moonpie.keyboard"
    keys:keyPressed("i")
    assert.spy(App.combat).was.called()
  end)
end)