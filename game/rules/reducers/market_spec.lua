-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.market", function()
  local market_reducer = require "game.rules.reducers.market"
  local action_types = require "game.rules.actions.types"
  local initial_state = {}

  describe("market reducers", function()
    it("can create an initial state", function()
      assert.same({}, market_reducer())
    end)

    it("sets the price of goods in the current market", function()
      local new_state = market_reducer(initial_state,
        {
          type = action_types.market_add_item,
          payload = { name = "Foo", price = 20}
        }
      )
      assert.equals("Foo", new_state["Foo"].name)
      assert.equals(20, new_state["Foo"].price)

      new_state = market_reducer(new_state, {
          type = action_types.market_add_item,
          payload = { name = "Foobar", price = 22 }

      })
      assert.equals("Foobar", new_state["Foobar"].name)
      assert.equals(22, new_state["Foobar"].price)
    end)
  end)
end)