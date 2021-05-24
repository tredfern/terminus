-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.furniture.door", function()
  local Door = require "game.rules.map.furniture.door"
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

        assert.thunk_dispatches({
          type = "WORLD_ENTITY_UPDATE",
          payload = {
            entity = closedDoor,
            values = {
              blocksMovement = false,
              blocksSight = false,
              closed = false
            }
          }
        }, action)
      end)

      it("plays a single shot of the opening animation", function()
        local action = Door.actions.open(closedDoor)
        assert.thunk_dispatches({
          type = "ANIMATION_PLAY_ONCE",
          payload = {
            animator = closedDoor.animator,
            animation = "opening"
          }
        }, action)
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

      it("locked doors can be unlocked", function()
        local unlockedDoor = createTestDoor(Position(1,1,1), true)
        local lockedDoor = createTestDoor(Position(1,1,1), true, true)

        local a1 = Door.actions.unlock(unlockedDoor)
        local a2 = Door.actions.unlock(lockedDoor)

        assert.is_falsy(a1:validate()) -- unlocked doors can't be unlocked
        assert.is_truthy(a2:validate()) -- locked doors can

        assert.same({
          entity = lockedDoor,
          values = { locked = false }
        }, a2.payload)
      end)
    end)
  end)

  it("can get the door at a specific location", function()
    local d = createTestDoor(Position(3, 4, 2))
    local d2 = createTestDoor(Position(3, 4, 5))
    local state = {
      world = {
        d, d2
      }
    }

    assert.equals(d, Door.selectors.getByPosition(state, Position(3, 4, 2)))
    assert.equals(d2, Door.selectors.getByPosition(state, Position(3, 4, 5)))
  end)
end)