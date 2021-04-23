-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.add_ladder", function()
  local addLadderDown = require "game.rules.map.actions.add_ladder_down"
  local Position = require "game.rules.world.position"

  it("creates an add-entity action with the ladder specs", function()
    local action = addLadderDown(Position(2, 4))
    assert.equals(2, action.payload.entity.position.x)
    assert.equals(4, action.payload.entity.position.y)
    assert.not_nil(action.payload.entity.sprite)
    assert.is_true(action.payload.entity.ladderDown)
  end)
end)