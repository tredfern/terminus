-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.combat", function()
  local combat = require "game.ui.screens.combat"

  it("renders a component", function()
    assert.not_nil(combat())
  end)
end)