-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers", function()
  local action_types = require "game.rules.actions.types"
  local root = require "game.rules.reducers"
  local initial_state = root()

  describe("initial state", function()
    local state = root()
    assert.not_nil(state)
    assert.not_nil(state.spaceports)
  end)

  describe("spaceport_add", function()
    it("creates a new state with a spaceport added", function()
      local new_state = root(initial_state, { type = action_types.spaceport_add, payload = { name = "Bravo" } })
      assert.not_empty_array(new_state.spaceports)
      assert.same({ name = "Bravo" }, new_state.spaceports[1])
    end)

    it("appends additional spaceports onto array without disrupting existing implementation", function()
      local state = { spaceports = {
        { name = "Alpha" }
      } }
      local new_state = root(state, { type = action_types.spaceport_add, payload = { name = "Bravo" }})

      assert.equals(1, #state.spaceports)
      assert.equals(2, #new_state.spaceports)
      assert.same({
        { name = "Alpha" },
        { name = "Bravo" }
      }, new_state.spaceports)
    end)
  end)

  describe("location_update", function()
    it("updates the location", function()
      local new_state = root(initial_state, { type = action_types.location_update, payload = { name = "Turtle" }})
      assert.equals("Turtle", new_state.location.name)
    end)
  end)

  describe("market reducers", function()
    it("sets the price of goods in the current market", function()
      local new_state = root(initial_state,
        {
          type = action_types.market_add_item,
          payload = { name = "Foo", price = 20}
        }
      )
      assert.equals("Foo", new_state.market_items[1].name)
      assert.equals(20, new_state.market_items[1].price)

      new_state = root(new_state, {
          type = action_types.market_add_item,
          payload = { name = "Foobar", price = 22 }

      })
      assert.equals("Foobar", new_state.market_items[2].name)
      assert.equals(22, new_state.market_items[2].price)
    end)
  end)

  describe("cargo reducers", function()
    it("adds cargo the player cargo to the specified value", function()
      local new_state = root( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 12
        }
      })
      new_state = root( new_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo 2", quantity = 22
        }
      })
      assert.is_true(moonpie.tables.any(new_state.player_cargo,
        function(v) return v.name == "Cargo" and v.quantity == 12 end))
      assert.is_true(moonpie.tables.any(new_state.player_cargo,
        function(v) return v.name == "Cargo 2" and v.quantity == 22 end))
    end)

    it("updates cargo with new quantity", function()
      root( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 12
        }
      })
      root( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 22
        }
      })
      local new_state = root( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 3
        }
      })
      assert.is_true(moonpie.tables.any(new_state.player_cargo,
        function(v) return v.name == "Cargo" and v.quantity == 3 end))
    end)
  end)
end)