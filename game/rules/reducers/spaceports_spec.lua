-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.spaceports", function()
  local action_types = require "game.rules.actions.types"
  local spaceport_reducer = require "game.rules.reducers.spaceports"
  local initial_state = {}

  describe("spaceport_add", function()
    it("can create an initial state", function()
      assert.same({}, spaceport_reducer())
    end)

    it("creates a new state with a spaceport added", function()
      local new_state = spaceport_reducer(
        initial_state,
        { type = action_types.spaceport_add, payload = { name = "Bravo" } }
      )
      assert.not_empty_array(new_state)
      assert.same({ name = "Bravo" }, new_state[1])
    end)

    it("appends additional spaceports onto array without disrupting existing implementation", function()
      local state = {
        { name = "Alpha" }
      }
      local new_state = spaceport_reducer(state, { type = action_types.spaceport_add, payload = { name = "Bravo" }})

      assert.equals(1, #state)
      assert.equals(2, #new_state)
      assert.same({
        { name = "Alpha" },
        { name = "Bravo" }
      }, new_state)
    end)
  end)
end)