-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.open_door", function()
  local openDoor = require "game.rules.player.actions.open_door"
  local Orientation = require "game.rules.world.orientation"
  local Position = require "game.rules.world.position"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local mockStore = require "test_helpers.mock_store"

  local northDoor, eastDoor

  before_each(function()
    northDoor = {
      door = true, closed = true,
      position = Position(1, 3, 3),
      blocksMovement = true,
      blocksSight = true,
      animator = { playOnce = spy.new(function() end )}
    }

    eastDoor = {
      door = true, closed = false,
      position = Position(2, 4, 3),
      animator = { playOnce = spy.new(function() end) }
    }
    mockDispatch.processComplex = true
    mockStore {
      characters = {},
      world = {
        { isPlayerControlled = true, position = Position(1, 4, 3)},
        northDoor,
        eastDoor
      }
    }
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("starts playing the open door animation on the door", function()
    local action = openDoor(Orientation.north)
    mockDispatch(action)

    assert.spy(northDoor.animator.playOnce).was.called_with(northDoor.animator, "opening")
    assert.is_false(northDoor.blocksMovement)
    assert.is_false(northDoor.blocksSight)
  end)

  it("does not open a door if it is already open", function()
    local action = openDoor(Orientation.east)
    mockDispatch(action)
    assert.spy(eastDoor.animator.playOnce).was.not_called()
  end)
end)