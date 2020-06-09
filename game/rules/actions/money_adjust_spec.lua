-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.money_adjust", function()
  local money_adjust = require "game.rules.actions.money_adjust"
  local types = require "game.rules.actions.types"

  it("sets the amount to adjust the player money account buy", function()
    local ma = money_adjust(384)
    assert.not_nil(ma.type)
    assert.equals(types.money_adjust, ma.type)
    assert.equals(384, ma.payload.amount)
  end)
end)