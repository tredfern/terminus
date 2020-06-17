-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_setup_shop", function()
  local types = require "game.rules.actions.types"
  local market_setup = require "game.rules.actions.market_setup_shop"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store{}
    store.dispatch(market_setup())
  end)

  it("sets the prices for items in the shop", function()
    assert.greater_than(0, #store.get_action_groups()[types.market_add_item])
  end)

end)