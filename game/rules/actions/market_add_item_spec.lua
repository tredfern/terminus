-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_add_item", function()
  local market_set_price = require "game.rules.actions.market_add_item"
  local types = require "game.rules.actions.types"

  it("defines the price that a good should currently be set to", function()
    local m = market_set_price("Good", 18)
    assert.equals(types.market_add_item, m.type)
    assert.equals("Good", m.payload.name)
    assert.equals(18, m.payload.price)
  end)
end)