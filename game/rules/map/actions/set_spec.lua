-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.set", function()
  local set = require "game.rules.map.actions.set"

  it("takes a map to be set", function()
    local map = {}
    local action = set(map)

    assert.equals(map, action.payload)
    assert.not_nil(action.type)
    assert.equals("MAP_SET", action.type)
  end)

end)