-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_buy", function()
  local market_buy = require "game.rules.actions.market_buy"
  local types = require "game.rules.actions.types"

  it("takes information on the name and price of good being bought", function()
    local m = market_buy("squid", 18)
    assert.equals(m.type, types.market_buy)
    assert.equals("squid", m.payload.name)
    assert.equals(18, m.payload.price)
  end)
end)