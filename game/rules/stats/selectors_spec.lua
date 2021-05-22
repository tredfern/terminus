-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("", function()
  local Selectors = require "game.rules.stats.selectors"

  describe("SELECTOR: getValue", function()
    local state = {
      stats = {
        statFoo = { value = 38 }
      }
    }

    it("returns the value of the stat if it's found", function()
      assert.equals(38, Selectors.getValue(state, "statFoo"))
    end)

    it("returns zero if the stat is not found", function()
      assert.equals(0, Selectors.getValue(state, "somethingMissing"))
    end)
  end)
end)