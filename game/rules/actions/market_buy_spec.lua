-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_buy", function()
  local market_buy = require "game.rules.actions.market_buy"
  local types = require "game.rules.actions.types"
  local mock_store = require "mock_store"
  local store, action_groups

  before_each(function()
    store = mock_store({})
    store.dispatch(market_buy("squid", 18))
    local state = store.get_state()
    action_groups = moonpie.utility.tables.group_by(state.actions, function(a) return a.type end)
  end)

  it("dispatches to add an item of cargo to the player", function()
    assert.equals(1, #action_groups[types.cargo_adjust])
    assert.equals(1, action_groups[types.cargo_adjust][1].payload.amount)
  end)
end)