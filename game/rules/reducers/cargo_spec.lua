-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.cargo", function()
  local action_types = require "game.rules.actions.types"
  local cargo_reducer = require "game.rules.reducers.cargo"
  local initial_state = {}

  describe("cargo reducers", function()
    it("can create an initial state", function()
      assert.same({ }, cargo_reducer())
    end)

    it("adds cargo the player cargo to the specified value", function()
      local new_state = cargo_reducer( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 12
        }
      })
      new_state = cargo_reducer( new_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo 2", quantity = 22
        }
      })
      assert.equals(12, new_state.Cargo.quantity)
      assert.equals(22, new_state["Cargo 2"].quantity)
    end)

    it("updates cargo with new quantity", function()
      cargo_reducer( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 22
        }
      })
      local new_state = cargo_reducer( initial_state, {
          type = action_types.cargo_update,
          payload = { name = "Cargo", quantity = 3
        }
      })
      assert.equals(3, new_state["Cargo"].quantity)
    end)

    it("can adjust the cargo amount", function()
      local new_state = cargo_reducer( initial_state, {
        type = action_types.cargo_adjust,
        payload = { name = "New Cargo", amount = 5 }
      })
      assert.equals(5, new_state["New Cargo"].quantity)
      new_state = cargo_reducer( new_state, {
        type = action_types.cargo_adjust,
        payload = { name = "New Cargo", amount = -2 }
      })
      assert.equals(3, new_state["New Cargo"].quantity)
    end)
  end)
end)