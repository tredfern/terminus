-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.money_update", function()
  local money_update = require "game.rules.actions.money_update"
  local types = require "game.rules.actions.types"

  it("sets the amount to set the player account to", function()
    local mu = money_update(748)
    assert.not_nil(mu.type)
    assert.equals(types.money_update, mu.type)
    assert.equals(748, mu.payload.amount)
  end)
end)