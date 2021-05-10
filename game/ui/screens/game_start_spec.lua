-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.game_start", function()
  local GameStart = require "game.ui.screens.game_start"

  it("creates a valid component", function()
    local gs = GameStart()
    assert.is_table(gs)
    assert.equals("game_start_screen", gs.id)
  end)
end)