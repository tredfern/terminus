-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.stats", function()
  local Stats = require "game.rules.stats"

  it("has an API that is super sweet", function()
    assert.is_table(Stats.actions)
    assert.is_table(Stats.selectors)
    assert.callable(Stats.reducer)
  end)
end)