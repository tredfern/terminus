-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.validators.player_has_funds", function()
  local player_has_funds = require "game.rules.validators.player_has_funds"

  it("returns true if funds is greater than or equal to a specified amount", function()
    local state = {
      player = { money = 173 }
    }

    assert.is_true(player_has_funds(state, 1))
    assert.is_true(player_has_funds(state, 172))
    assert.is_true(player_has_funds(state, 173))
    assert.is_false(player_has_funds(state, 174))
    assert.is_false(player_has_funds(state, 3729938))
  end)
end)