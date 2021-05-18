-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player", function()
  local Player = require "game.rules.player"
  local Position = require "game.rules.world.position"
  local Orientation = require "game.rules.world.orientation"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Characters = require "game.rules.character"

  describe("ACTION: add", function()
    it("creates a character with the player image", function()
      local action = Player.actions.add(Position(3, 4, 3))
      local player = action.payload.character
      assert.equals(3, player.position.x)
      assert.equals(4, player.position.y)
      assert.equals(3, player.position.z)
      assert.is_true(player.isPlayerControlled)
    end)

    it("identifies as a sight-enabled creature", function()
      local action = Player.actions.add()
      assert.not_nil(action.payload.character.sightRadius)
    end)
  end)

  it("ACTION: equipItem", function()
    local player = { isPlayerControlled = true }
    mockStore({ characters = { player } })
    local item = {}
    local action = Player.actions.equipItem(item)
    assert.equals(item, action.payload.item)
    assert.equals(player, action.payload.character)
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
      local action = Player.actions.ladderDown()
      assert.thunk_dispatches_type(action, "CHARACTER_MOVE")
    end)

    it("moves up if there is a ladder in the current location", function()
      mockStore {
        characters = {},
        world = {
          { isPlayerControlled = true, position = Position(1, 4, 3)},
          { ladderUp = true, position = Position(1, 4, 3) }
        }
      }
      local action = Player.actions.ladderUp()
      assert.thunk_dispatches_type(action, "CHARACTER_MOVE")
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
      mockDispatch(Player.actions.move(Position.north))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(10, 9))
    end)

    it("can move the character east", function()
      mockDispatch(Player.actions.move(Position.east))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(11, 10))
    end)

    it("can move the character south", function()
      mockDispatch(Player.actions.move(Position.south))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(10, 11))
    end)

    it("can move the character west", function()
      mockDispatch(Player.actions.move(Position.west))
      assert.spy(Characters.actions.move).was.called_with(playerCharacter, match.is_position(9, 10))
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
      local action = Player.actions.openDoor(Orientation.north)
      assert.thunk_dispatches_type(action, "DOOR_OPEN")
    end)

    it("does not dispatch an action if the door is missing", function()
      local action = Player.actions.openDoor(Orientation.north)
      assert.not_thunk_dispatches(action, "DOOR_OPEN")
    end)

    it("sends a message if the door is locked", function()
      local action = Player.actions.openDoor(Orientation.east)
      assert.thunk_dispatches_type(action, "MESSAGE_LOG_ADD")
    end)

    it("unlocks a locked door if the player is carrying a key card", function()
      player.inventory = { { item = { key = "keycard" } } }
      local action = Player.actions.openDoor(Orientation.east)

      assert.thunk_dispatches_type(action, "WORLD_ENTITY_UPDATE")
    end)
  end)

  describe("game.rules.player.actions.pickup_items", function()
    local playerCharacter = { isPlayerControlled = true, position = { x = 10, y = 10 } }

    before_each(function()
      mockDispatch.processComplex = true
      mockStore({
        characters = { playerCharacter },
        items = {}
      })
    end)

    after_each(function()
      mockDispatch:reset()
    end)

    it("dispatches the pickupItems action with the player character", function()
      spy.on(Characters.actions, "pickupItems")

      mockDispatch(Player.actions.pickupItems())
      assert.spy(Characters.actions.pickupItems).was.called_with(playerCharacter)
    end)
  end)

  describe("SELECTOR: getFieldOfView", function()
    it("finds the player and then gets its FoV", function()
      local player = { isPlayerControlled = true }
      local fov = { }
      local state = {
        world = {
          player
        },
        fieldOfView = {
          [player] = fov
        }
      }

      assert.equals(fov, Player.selectors.getFieldOfView(state))
    end)
  end)

  describe("SELECTOR: getPlayer", function()
    it("can search state and return the player character if it exists", function()
      local player = { isPlayerControlled = true }
      local state = {
        characters = {
          player
        }
      }

      assert.equals(player, Player.selectors.getPlayer(state))
    end)
  end)

  describe("SELECTOR: hasItemOfKind", function()
    it("returns true if player inventory has an item of a matching key", function()
      local player = { isPlayerControlled = true, inventory = { { item = { key = "A" } }, { item = { key = "B" } } } }
      local state = { characters = { player } }

      assert.is_true(Player.selectors.hasItemOfKind(state, "A"))
      assert.is_true(Player.selectors.hasItemOfKind(state, "B"))
      assert.is_false(Player.selectors.hasItemOfKind(state, "C"))
    end)
  end)
end)