-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widget.player_panel", function()
  local player_panel = require "game.ui.widgets.player_panel"

  it("instantiates properly", function()
    assert.not_nil(player_panel())
  end)

end)