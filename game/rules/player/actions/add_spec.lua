-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.add", function()
  local add = require "game.rules.player.actions.add"
  local Position = require "game.rules.world.position"

  it("creates a character with the player image", function()
    local action = add(Position(3, 4, 3))
    local player = action.payload.character
    assert.equals(3, player.position.x)
    assert.equals(4, player.position.y)
    assert.equals(3, player.position.z)
    assert.is_true(player.isPlayerControlled)
  end)
end)