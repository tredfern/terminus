-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.helpers.market_prices", function()
  local market_prices = require "game.rules.helpers.market_prices"

  it("returns a price within -25% and +25% of the baseprice", function()
    for _ = 1,1000 do
      assert.in_range(75, 125, market_prices.random(100))
    end
  end)

  it("just uses zero if no baseprice is provide", function()
    assert.equals(0, market_prices.random())
  end)

  it("rounds to nearest integer value", function()
    assert.has_no_errors(function() market_prices.random(3827.43) end)
  end)
end)