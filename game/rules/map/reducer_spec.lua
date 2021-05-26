-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.reducer", function()
  local reducer = require "game.rules.map.reducer"
  local types = require "game.rules.map.types"
  local Position = require "game.rules.world.position"

  it("sets the state to the value of the map on the set action", function()
    local outline, tileMap = {}, {}
    local state = reducer({}, {
      type = types.ADD,
      payload = {
        outline = outline,
        tileMap = tileMap
      }
    })

    assert.equals(outline, state.outline)
    assert.equals(tileMap, state.tileMap)
  end)

  describe("ACTION: addRoom", function()
    local action = {
      type = types.ADD_ROOM,
      payload = {
        room = {
          x = 10, y = 10, width = 10, height = 10, level = 2, description = "Foo"
        }
      }
    }

    it("adds room to the outline", function()
      local state = reducer({}, action)
      assert.same(action.payload.room, state.outline.rooms[1])
    end)

    it("fills in the tile map", function()
      local state = reducer({}, action)
      assert.equals(action.payload.room, state.tileMap[Position(10, 10, 2)].room)
      assert.equals(action.payload.room, state.tileMap[Position(13, 19, 2)].room)
      assert.equals(action.payload.room, state.tileMap[Position(18, 14, 2)].room)
      assert.not_nil(state.tileMap[Position(10, 10, 2)].terrain)
      assert.not_nil(state.tileMap[Position(11, 11, 2)].terrain)
      assert.not_nil(state.tileMap[Position(12, 12, 2)].terrain)
      assert.not_nil(state.tileMap[Position(13, 13, 2)].terrain)
      assert.not_nil(state.tileMap[Position(20, 20, 2)].terrain)
    end)
  end)

  describe("ACTION: addCorridor", function()
    local action = {
      type = types.ADD_CORRIDOR,
      payload = {
        corridor = {
          path = {
            Position(10, 21, 2),
            Position(11, 21, 2),
            Position(12, 21, 2),
            Position(12, 22, 2),
            Position(12, 23, 2),
            Position(12, 24, 2),
          }
        }
      }
    }

    it("fills in the tiles with the corridor", function()
      local state = reducer({}, action)
      assert.not_nil(state.tileMap[Position(10, 21, 2)].terrain)
      assert.not_nil(state.tileMap[Position(11, 21, 2)].terrain)
      assert.not_nil(state.tileMap[Position(12, 21, 2)].terrain)
      assert.not_nil(state.tileMap[Position(12, 22, 2)].terrain)
      assert.not_nil(state.tileMap[Position(12, 23, 2)].terrain)
      assert.not_nil(state.tileMap[Position(12, 24, 2)].terrain)
    end)

    it("does not fill in a tile that is already filled in", function()
      local t = {}
      local state = reducer({ tileMap = { [Position(10, 21, 2)] = t }}, action)
      assert.equals(t, state.tileMap[Position(10, 21, 2)])
    end)
  end)
end)