-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.actions.add_alien", function()
  local addAlien = require "game.rules.aliens.actions.add_alien"
  local Position = require "game.rules.world.position"

  it("sets up a character with the alien properties", function()
    local action = addAlien(Position(20, 39))
    local alien = action.payload.character
    assert.equals(20, alien.position.x)
    assert.equals(39, alien.position.y)
    assert.not_nil(alien.ai)
    assert.is_true(alien.alien)
    assert.not_nil(alien.animator)
  end)
end)