-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.open_door", function()
  local openDoor = require "game.rules.player.actions.open_door"
  local Orientation = require "game.rules.world.orientation"
  local Position = require "game.rules.world.position"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local northDoor

  before_each(function()
    northDoor = { door = true, position = Position(1, 3, 3),
    }

    mockStore {
      characters = {},
      world = {
        { isPlayerControlled = true, position = Position(1, 4, 3)},
        northDoor,
      }
    }
  end)

  it("dispatches an open door action if there is a door available", function()
    local action = openDoor(Orientation.north)
    assert.thunk_dispatches_type(action, "DOOR_OPEN")
  end)

  it("does not dispatch an action if the door is missing", function()
    local action = openDoor(Orientation.north)
    assert.not_thunk_dispatches(action, "DOOR_OPEN")
  end)
end)