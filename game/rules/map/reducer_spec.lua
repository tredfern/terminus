-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.reducer", function()
  local reducer = require "game.rules.map.reducer"
  local types = require "game.rules.map.actions.types"

  it("sets the state to the value of the map on the set action", function()
    local map = {}
    local state = reducer({}, {
      type = types.set,
      payload = map
    })

    assert.equals(map, state)
  end)
end)