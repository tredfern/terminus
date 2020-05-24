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
end)