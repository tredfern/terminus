-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.market_sell", function()
  local market_sell = require "game.rules.actions.market_sell"
  local types = require "game.rules.actions.types"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store({
      player_cargo = {
        ["squid"] = { quantity = 15 },
        ["herring"] = { quantity = 0 }
      }
    })
  end)

  it("dispatches to add an item of cargo to the player", function()
    store.dispatch(market_sell("squid", 18))
    local state = store.get_state()
    local action_groups = moonpie.utility.tables.group_by(state.actions, function(a) return a.type end)
    assert.equals(1, #action_groups[types.cargo_adjust])
    assert.equals(-1, action_groups[types.cargo_adjust][1].payload.amount)
  end)

  it("ignores selling if there is no cargo for the player", function()
    store.dispatch(market_sell("herring", 18))
    local state = store.get_state()
    assert.is_nil(state.actions)
  end)
end)