-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.game_view_set", function()
  local game_view_set = require "game.rules.actions.game_view_set"
  local types = require "game.rules.actions.types"

  it("takes a table to use for the current game view", function()
    local v = {}

    local action = game_view_set(v)
    assert.equals(v, action.payload)
    assert.not_nil(action.type)
    assert.equals(types.game_view_set, action.type)

  end)
end)