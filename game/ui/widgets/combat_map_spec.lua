-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.combat_map", function()
  local combat_map = require "game.ui.widgets.combat_map"

  it("renders a component", function()
    assert.is_table(combat_map())
  end)

end)