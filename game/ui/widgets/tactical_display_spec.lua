-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.tactical_display", function()
  local tactical_display = require "game.ui.widgets.tactical_display"

  it("renders a component", function()
    assert.not_nil(tactical_display())
    assert.is_table(tactical_display())
  end)
end)