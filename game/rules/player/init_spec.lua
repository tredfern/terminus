-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player", function()
  local player = require "game.rules.player"

  it("has the actions the player can perform", function()
    assert.not_nil(player.actions.move)
  end)

  it("has selectors to retrieve player values", function()
    assert.not_nil(player.selectors.getPlayerCharacter)
  end)
end)