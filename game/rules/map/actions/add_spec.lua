-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.add", function()
  local add = require "game.rules.map.actions.add"

  it("takes a map to be added", function()
    local outline, tileMap = {}, {}
    local action = add(outline, tileMap)

    assert.equals(outline, action.payload.outline)
    assert.equals(tileMap, action.payload.tileMap)
    assert.not_nil(action.type)
    assert.equals("MAP_ADD", action.type)
  end)

end)