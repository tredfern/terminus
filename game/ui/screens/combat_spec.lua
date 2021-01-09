-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.combat", function()
  local combat_screen = require "game.ui.screens.combat"
  local moonpie = require "moonpie"
  local mock_store = require "mock_store"
  mock_store({
    turn = {
      counter = 10
    }
  })

  it("creates a component", function()
    assert.is_table(combat_screen())
  end)

  it("renders a map", function()
    assert.contains_component("combat_map", combat_screen())
  end)

  describe("keyboard configuration", function()
    local keyboard_map = require "game.ui.inputs.keyboard_map"
    spy.on(keyboard_map, "enable_combat_map")
    spy.on(keyboard_map, "disable_combat_map")

    it("assigns and removes it's hotkeys on mounting and unmounting", function()
      moonpie.test_render(combat_screen())
      assert.spy(keyboard_map.enable_combat_map).was.called()
      moonpie.test_render(nil)
      assert.spy(keyboard_map.disable_combat_map).was.called()
    end)

  end)
end)