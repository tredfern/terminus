-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.add", function()
  local add = require "game.rules.player.actions.add"
  local imageMgr = require "moonpie.graphics.image"

  it("creates a character with the player image", function()
    local action = add(3, 4)
    local player = action.payload.character
    assert.equals(3, player.x)
    assert.equals(4, player.y)
    assert.is_true(player.isPlayerControlled)
    assert.equals(imageMgr.load("assets/graphics/simple-character-1.png"), player.sprite.imageData)
  end)
end)