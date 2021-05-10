-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.achievements", function()
  local Achievements = require "game.ui.screens.achievements"

  it("creates a component", function()
    local s = Achievements()
    assert.is_table(s)
    assert.equals("achievements_screen", s.id)
  end)
end)