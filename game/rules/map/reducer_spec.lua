-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.reducer", function()
  local reducer = require "game.rules.map.reducer"
  local types = require "game.rules.map.actions.types"

  it("sets the state to the value of the map on the set action", function()
    local outline, tileMap = {}, {}
    local state = reducer({}, {
      type = types.ADD,
      payload = {
        outline = outline,
        tileMap = tileMap
      }
    })

    assert.equals(outline, state.outline)
    assert.equals(tileMap, state.tileMap)
  end)
end)