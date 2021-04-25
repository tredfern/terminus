-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.open_door", function()
  local openDoor = require "game.rules.player.actions.open_door"
  local mockDispatch = require "test_helpers.mock_dispatch"

  before_each(function()
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("starts playing the open door animation on the door", function()
    local door = {
      animator = { play = spy.new(function() end) }
    }

    local action = openDoor(door)
    mockDispatch(action)


    assert.spy(door.animator.play).was.called_with(door.animator, "opening")
  end)
end)