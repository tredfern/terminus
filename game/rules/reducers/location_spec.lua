-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.location", function()
  local action_types = require "game.rules.actions.types"
  local location_reducer = require "game.rules.reducers.location"
  local initial_state = {}


  describe("location_update", function()
    it("can create an initial state", function()
      assert.same({ name = "Unknown" }, location_reducer())
    end)

    it("updates the location", function()
      local new_state = location_reducer(
        initial_state,
        { type = action_types.location_update, payload = { name = "Turtle" }}
      )
      assert.equals("Turtle", new_state.name)
    end)
  end)
end)