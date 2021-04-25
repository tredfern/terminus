-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.add_door", function()
  local addDoor = require "game.rules.map.actions.add_door"
  local Position = require "game.rules.world.position"
  local Orientation = require "game.rules.world.orientation"

  it("specifies a door entity to add", function()
    local action = addDoor(Position(2, 2, 3), Orientation.northSouth)
    assert.is_True(Position.equal(action.payload.entity.position, { 2, 2, 3}))
    assert.is_true(action.payload.entity.door)
    assert.is_true(action.payload.entity.closed)
    assert.is_true(action.payload.entity.blocksMovement)
    assert.not_nil(action.payload.entity.sprite)
    assert.equals(Orientation.northSouth, action.payload.entity.orientation)
  end)
end)