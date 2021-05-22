-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("", function()
  local reducer = require "game.rules.stats.reducer"
  local actionTypes = require "game.rules.stats.types"

  describe("STATISTIC_COUNT", function()
    local action = {
      type = actionTypes.COUNT,
      payload = {
        count = 3,
        stat = "statsd"
      }
    }

    it("sets the value to the increment if the value has not been seen before", function()
      local state = {}

      state = reducer(state, action)
      assert.equals(3, state.statsd.value)
    end)

    it("increments the value if there is already a value", function()
      local state = { statsd = { value = 12 } }
      state = reducer(state, action)
      assert.equals(15, state.statsd.value)
    end)
  end)

  describe("STATISTIC_SET", function()
    local action = {
      type = actionTypes.SET,
      payload = {
        value = 38,
        stat = "statsd"
      }
    }

    it("sets the value to the value if the stat did not already exist", function()
      local state = reducer({}, action)
      assert.equals(38, state.statsd.value)
    end)

    it("overwrites a value if it already exists", function()
      local state = reducer({ stats = { value = 12 }}, action)
      assert.equals(38, state.statsd.value)
    end)
  end)
end)