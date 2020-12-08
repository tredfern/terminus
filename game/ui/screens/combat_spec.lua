-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.combat", function()
  local combat_screen = require "game.ui.screens.combat"

  it("creates a component", function()
    assert.is_table(combat_screen())
  end)

  it("renders a map", function()
    assert.contains_component("combat_map", combat_screen())
  end)
end)