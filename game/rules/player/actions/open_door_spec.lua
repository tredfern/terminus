-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.open_door", function()
  local openDoor = require "game.rules.player.actions.open_door"
  local Orientation = require "game.rules.world.orientation"
  local Position = require "game.rules.world.position"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local northDoor, lockedDoor, player

  before_each(function()
    northDoor = { door = true, position = Position(1, 3, 3), }
    lockedDoor = { door = true, position = Position(2, 4, 3), locked = true }
    player = { isPlayerControlled = true, position = Position(1, 4, 3) }

    mockStore {
      characters = { player },
      world = {
        northDoor,
        lockedDoor
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

  it("sends a message if the door is locked", function()
    local action = openDoor(Orientation.east)
    assert.thunk_dispatches_type(action, "MESSAGE_LOG_ADD")
  end)

  it("unlocks a locked door if the player is carrying a key card", function()
    player.inventory = { { item = { key = "keycard" } } }
    local action = openDoor(Orientation.east)

    assert.thunk_dispatches_type(action, "WORLD_ENTITY_UPDATE")
  end)
end)