-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.add", function()
  local add = require "game.rules.player.actions.add"

  it("creates a character with the player image", function()
    local action = add(3, 4)
    local player = action.payload.character
    assert.equals(3, player.position.x)
    assert.equals(4, player.position.y)
    assert.is_true(player.isPlayerControlled)
  end)
end)