-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.new_game", function()
  local rules = require "game.rules"
  local state = require "game.state"

  before_each(function()
  end)

  it("creates a map of spaceports", function()
    rules.new_game(state)
    assert.not_nil(state.spaceports)
  end)

  it("sets up a new player", function()
    rules.new_game(state)
    assert.not_nil(state.player)
  end)
end)