-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player", function()
  local Player = require "game.rules.player"

  it("has a clean api", function()
    assert.not_nil(Player.actions)
    assert.not_nil(Player.selectors)
    assert.not_nil(Player.reducer)
  end)
end)