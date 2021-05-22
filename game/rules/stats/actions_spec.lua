-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.stats.actions", function()
  local Actions = require "game.rules.stats.actions"

  describe("ACTION: count", function()
    it("create a count action to increment some value an amount", function()
      local action = Actions.count(5, "stat_a_b_c")
      assert.equals(Actions.types.COUNT, action.type)
      assert.equals(5, action.payload.count)
      assert.equals("stat_a_b_c", action.payload.stat)
    end)
  end)

  describe("ACTION: set", function()
    it("creates a set action to set the value to specific value", function()
      local action = Actions.set(182, "statd")
      assert.equals(Actions.types.SET, action.type)
      assert.equals(182, action.payload.value)
      assert.equals("statd", action.payload.stat)
    end)
  end)
end)