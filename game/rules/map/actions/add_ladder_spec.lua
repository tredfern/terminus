-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.add_ladder", function()
  local addLadder = require "game.rules.map.actions.add_ladder"

  it("creates an add-entity action with the ladder specs", function()
    local action = addLadder(2, 4)
    assert.equals(2, action.payload.entity.x)
    assert.equals(4, action.payload.entity.y)
    assert.not_nil(action.payload.entity.sprite)
  end)
end)