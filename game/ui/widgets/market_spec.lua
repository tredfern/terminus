-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.market", function()
  local mock_store = require "mock_store"
  local action_types = require "game.rules.actions.types"
  local market = require "game.ui.widgets.market"
  local rendered, store

  before_each(function()
    store = mock_store({
      market_items = {
        { name = "Organics", price = 15, quantity = 12 },
        { name = "Technology", price = 16, quantity = 11 },
        { name = "Contraband", price = 17, quantity = 10 }
      }
    })
    rendered = moonpie.test_render(market())
  end)

  it("displays an entry for each item", function()
    assert.equals("Organics", rendered:find_by_id("Organics_name").text)
    assert.equals("15", rendered:find_by_id("Organics_price").text)
    assert.equals("Technology", rendered:find_by_id("Technology_name").text)
    assert.equals("16", rendered:find_by_id("Technology_price").text)
  end)

  it("has a buy button that dispatches a market_buy request", function()
    local buy = rendered:find_by_id("Organics_buy")
    buy:click()
    assert.is_true(moonpie.tables.any(
      store.get_state().actions,
      function(a) return a.type == action_types.market_buy end)
    )
  end)

  it("has a sell button that transfers cargo back to the market", function()
    local sell = rendered:find_by_id("Organics_sell")
    sell:click()

    assert.is_true(moonpie.tables.any(
      store.get_state().actions,
      function(a) return a.type == action_types.market_sell end)
    )
  end)
end)