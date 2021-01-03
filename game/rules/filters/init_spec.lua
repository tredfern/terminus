-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.filters", function()
  local filters = require "game.rules.filters"

  it("is a table of all the filters", function()
    assert.is_table(filters)
    assert.is_function(filters.find_player_character)
  end)
end)