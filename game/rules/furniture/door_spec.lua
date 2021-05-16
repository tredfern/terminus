-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.furniture.door", function()
  local Door = require "game.rules.furniture.door"
  local Position = require "game.rules.world.position"
  local Orientation = require "game.rules.world.orientation"
  local mockStore = require "moonpie.test_helpers.mock_store"

  local createTestDoor = function(position, closed, locked)
    return {
      door = true, closed = closed,
      position = position,
      blocksMovement = closed,
      blocksSight = closed,
      animator = { playOnce = spy.new(function() end )},
      locked = locked
    }
  end

  describe("actions", function()
    describe("adding", function()
      it("specifies a door entity to add", function()
        local action = Door.actions.add(Position(2, 2, 3), Orientation.northSouth)
        assert.is_True(Position.equal(action.payload.entity.position, { 2, 2, 3}))
        assert.is_true(action.payload.entity.door)
        assert.is_true(action.payload.entity.closed)
        assert.is_true(action.payload.entity.blocksMovement)
        assert.is_true(action.payload.entity.blocksSight)
        assert.not_nil(action.payload.entity.sprite)
        assert.equals(Orientation.northSouth, action.payload.entity.orientation)
      end)

      it("is invalid if there is already a door at the location", function()
        mockStore {
          world = {
            { position = Position(2, 2, 3), door = true }
          }
        }
        local action = Door.actions.add(Position(2, 2, 3), Orientation.northSouth)
        assert.is_nil(action)
      end)
    end)

    describe("opening", function()
      local closedDoor, openDoor, lockedDoor

      before_each(function()
        closedDoor = createTestDoor(Position(1, 3, 3), true)
        openDoor = createTestDoor(Position(2, 4, 3), false)
        lockedDoor = createTestDoor(Position(3, 4, 8), true, true)
      end)

      it("updates the door properties to be open", function()
        local action = Door.actions.open(closedDoor)

        assert.thunk_dispatches(action, {
          type = "WORLD_ENTITY_UPDATE",
          payload = {
            entity = closedDoor,
            values = {
              blocksMovement = false,
              blocksSight = false,
              closed = false
            }
          }
        })
      end)

      it("plays a single shot of the opening animation", function()
        local action = Door.actions.open(closedDoor)
        assert.thunk_dispatches(action, {
          type = "ANIMATION_PLAY_ONCE",
          payload = {
            animator = closedDoor.animator,
            animation = "opening"
          }
        })
      end)

      it("does not open a door if it is already open", function()
        local action = Door.actions.open(openDoor)
        assert.is_false(action:validate())
      end)

      it("does not open a locked door", function()
        local action = Door.actions.open(lockedDoor)
        assert.is_false(action:validate())
      end)
    end)

    describe("locking doors", function()
      it("is valid if the door is closed and unlocked", function()
        local unlockedDoor = createTestDoor(Position(1,1,1), true)
        local openDoor = createTestDoor(Position(1,1,1), false)
        local lockedDoor = createTestDoor(Position(1,1,1), true, true)

        local a1 = Door.actions.lock(unlockedDoor)
        local a2 = Door.actions.lock(openDoor)
        local a3 = Door.actions.lock(lockedDoor)

        assert.is_true(a1:validate())
        assert.is_false(a2:validate())
        assert.is_false(a3:validate())
      end)

      it("sets the door to locked", function()
        local unlockedDoor = createTestDoor(Position(1,1,1), true)
        local action = Door.actions.lock(unlockedDoor)
        assert.same({
          entity = unlockedDoor,
          values = { locked = true }
        }, action.payload)
      end)
    end)
  end)
end)