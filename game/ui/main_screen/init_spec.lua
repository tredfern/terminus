-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.main_screen", function()
  local mainScreen = require "game.ui.main_screen"
  local moonpie = require "moonpie"
  local mockStore = require "moonpie.test_helpers.mock_store"
  mockStore({
    characters = {},
    turn = {
      counter = 10
    }
  })

  it("creates a component", function()
    assert.is_table(mainScreen())
  end)

  it("renders a map", function()
    assert.contains_component("combat_map", mainScreen())
  end)

  describe("keyboard configuration", function()
    local keyboard_map = require "game.ui.inputs.keyboard_map"
    spy.on(keyboard_map, "enableCombatMap")
    spy.on(keyboard_map, "disableCombatMap")

    it("assigns and removes it's hotkeys on mounting and unmounting", function()
      moonpie.testRender(mainScreen())
      assert.spy(keyboard_map.enableCombatMap).was.called()
      moonpie.testRender(nil)
      assert.spy(keyboard_map.disableCombatMap).was.called()
    end)
  end)
end)