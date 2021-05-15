-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.furniture.door", function()
  local Door = require "game.rules.furniture.door"
  local Position = require "game.rules.world.position"
  local Orientation = require "game.rules.world.orientation"
  local mockStore = require "moonpie.test_helpers.mock_store"

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
  end)
end)