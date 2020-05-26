-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_sell", function()
  local market_sell = require "game.rules.actions.market_sell"
  local types = require "game.rules.actions.types"

  it("takes information on the name and price of product", function()
    local m = market_sell("seeds", 48)
    assert.equals(types.market_sell, m.type)
    assert.equals("seeds", m.payload.name)
    assert.equals(48, m.payload.price)
  end)
end)