-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player", function()
  local Actions = require "game.rules.player.actions"
  local Position = require "game.rules.world.position"
  local Orientation = require "game.rules.world.orientation"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Characters = require "game.rules.character"

  describe("ACTION: add", function()
    it("creates a character with the player image", function()
      local action = Actions.add(Position(3, 4, 3))
      local player = action.payload.character
      assert.equals(3, player.position.x)
      assert.equals(4, player.position.y)
      assert.equals(3, player.position.z)
      assert.is_true(player.isPlayerControlled)
    end)

    it("identifies as a sight-enabled creature", function()
      local action = Actions.add()
      assert.not_nil(action.payload.character.sightRadius)
    end)
  end)

  it("ACTION: equipItem", function()
    local player = { isPlayerControlled = true }
    mockStore({ characters = { player } })
    local item = {}
    local action = Actions.equipItem(item)
    assert.equals(item, action.payload.item)
    assert.equals(player, action.payload.entity)
  end)

  describe("ACTION: ladderDown/ladderUp", function()
    it("moves up if there is a ladder in the current location", function()
      mockStore {
        characters = {},
        world = {
          { isPlayerControlled = true, position = Position(1, 4, 3)},
          { ladderDown = true, position = Position(1, 4, 3) }
        }
      }
      local action = Actions.ladderDown()
      assert.thunk_dispatches_type("PLAYER_MOVE", action)
    end)

    it("moves up if there is a ladder in the current location", function()
      mockStore {
        characters = {},
        world = {
          { isPlayerControlled = true, position = Position(1, 4, 3)},
          { ladderUp = true, position = Position(1, 4, 3) }
        }
      }
      local action = Actions.ladderUp()
      assert.thunk_dispatches_type("PLAYER_MOVE", action)
    end)
  end)

  describe("ACTION: move", function()
    local playerCharacter
    before_each(function()
      playerCharacter = { position = Position(10, 10), isPlayerControlled = true }
      mockStore({
        characters = {
          playerCharacter
        }
      })
      mockDispatch.processComplex = true
      spy.on(Characters.actions, "move")
    end)

    after_each(function()
      mockDispatch:reset()
    end)

    it("can move the character north", function()
      mockDispatch(Actions.move(Position.north))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(10, 9))
    end)

    it("can move the character east", function()
      mockDispatch(Actions.move(Position.east))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(11, 10))
    end)

    it("can move the character south", function()
      mockDispatch(Actions.move(Position.south))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(10, 11))
    end)

    it("can move the character west", function()
      mockDispatch(Actions.move(Position.west))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(9, 10))
    end)

    it("dispatches entered room if room", function()
      local Map = require "game.rules.map"
      moonpie.utility.swapFunction(Map.selectors, "getTile", function() return { room = {} } end)

      assert.thunk_dispatches_type("PLAYER_ENTERED_ROOM", Actions.move(Position.west))

      Map.selectors.getTile:revert()
    end)
  end)

  describe("ACTION: openDoor", function()
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
      local action = Actions.openDoor(Orientation.north)
      assert.thunk_dispatches_type("DOOR_OPEN", action)
    end)

    it("does not dispatch an action if the door is missing", function()
      local action = Actions.openDoor(Orientation.north)
      assert.not_thunk_dispatches("DOOR_OPEN", action)
    end)

    it("sends a message if the door is locked", function()
      local action = Actions.openDoor(Orientation.east)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)

    it("unlocks a locked door if the player is carrying a key card", function()
      player.inventory = { { item = { key = "keycard" } } }
      local action = Actions.openDoor(Orientation.east)

      assert.thunk_dispatches_type("WORLD_ENTITY_UPDATE", action)
    end)
  end)

  describe("ACTION: PickupItems", function()
    local playerCharacter = { isPlayerControlled = true, position = Position(10, 10, 1) }
    local item1, item2 = { item = true, position = Position(10, 10, 1) }, { item = true, position = Position(10, 10, 1)}

    before_each(function()
      mockDispatch.processComplex = true
      mockStore({
        characters = { playerCharacter },
        world = {
          item1, item2
        }
      })
    end)

    after_each(function()
      mockDispatch:reset()
    end)

    it("adds the items to the inventory", function()
      local Inventory = require "game.rules.inventory"
      local action = Actions.pickupItems()
      assert.thunk_dispatches(Inventory.actions.addItem(playerCharacter, item1), action)
      assert.thunk_dispatches(Inventory.actions.addItem(playerCharacter, item2), action)
    end)

    it("removes the items from the map", function()
      local Items = require "game.rules.items"
      local action = Actions.pickupItems()
      assert.thunk_dispatches(Items.actions.remove(item1), action)
      assert.thunk_dispatches(Items.actions.remove(item2), action)
    end)
  end)

  describe("ACTION: enteredRoom", function()
    it("displays a description if the room has not been entered before", function()
      local room = {
        description = "Hello"
      }

      local action = Actions.enteredRoom(room)
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)

    it("marks the rooms has visited", function()
      local room = { }

      local action = Actions.enteredRoom(room)
      assert.thunk_dispatches({
        type = "PLAYER_TRACK_ROOM_VISIT",
        payload = {
          room = room
        }
      }, action)
    end)

    it("does nothing if room is nil", function()
      assert.is_nil(Actions.enteredRoom(nil))
    end)

    it("does nothing if the room has already been visited", function()
    end)
  end)

  describe("ACTION: trackRoomVisit", function()
    it("sets up an action to track a room visit", function()
      local room = {}
      local action = Actions.trackRoomVisit(room)

      assert.equals("PLAYER_TRACK_ROOM_VISIT", action.type)
      assert.equals(room, action.payload.room)
    end)
  end)
end)