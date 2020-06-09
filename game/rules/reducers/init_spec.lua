-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers", function()
  local root = require "game.rules.reducers"

  describe("initial state", function()
    local state = root()
    assert.not_nil(state)
    assert.not_nil(state.spaceports)
  end)

  it("has state for the player", function()
    local state = root()
    assert.not_nil(state.player)
  end)
end)