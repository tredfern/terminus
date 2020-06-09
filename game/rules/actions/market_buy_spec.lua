-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_buy", function()
  local market_buy = require "game.rules.actions.market_buy"
  local types = require "game.rules.actions.types"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store({
      player = {
        money = 32
      }
    })
  end)

  it("dispatches to add an item of cargo to the player", function()
    store.dispatch(market_buy("squid", 18))
    local action_groups = store.get_action_groups()
    assert.equals(1, #action_groups[types.cargo_adjust])
    assert.equals(1, action_groups[types.cargo_adjust][1].payload.amount)
  end)

  it("dispatches to reduce money by price of item", function()
    store.dispatch(market_buy("squid", 18))
    local action_groups = store.get_action_groups()
    assert.equals(1, #action_groups[types.money_adjust])
    assert.equals(-18, action_groups[types.money_adjust][1].payload.amount)
  end)

  it("does not execute any commands if the player does not have enough money", function()
    store.dispatch(market_buy("expensive", 38828833))
    local action_groups = store.get_action_groups()
    assert.is_nil(action_groups[types.money_adjust])
    assert.is_nil(action_groups[types.cargo_adjust])
  end)
end)