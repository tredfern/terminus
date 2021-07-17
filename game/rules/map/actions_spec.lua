-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions", function()
  local Actions = require "game.rules.map.actions"
  local Position = require "game.rules.world.position"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"

  describe("ACTION: addLadderDown", function()
    it("creates an add-entity action with the ladder specs", function()
      local action = Actions.addLadderDown(Position(2, 4))
      assert.equals(2, action.payload.entity.position.x)
      assert.equals(4, action.payload.entity.position.y)
      assert.not_nil(action.payload.entity.sprite)
      assert.is_true(action.payload.entity.ladderDown)
    end)
  end)

  describe("ACTION: addLadderUp", function()
    it("creates an add-entity action with the ladder specs", function()
      local action = Actions.addLadderUp(Position(2, 4))
      assert.equals(2, action.payload.entity.position.x)
      assert.equals(4, action.payload.entity.position.y)
      assert.not_nil(action.payload.entity.sprite)
      assert.is_true(action.payload.entity.ladderUp)
    end)
  end)

  describe("ACTION: add", function()
    it("takes a map to be added", function()
      local outline, tileMap = {}, {}
      local action = Actions.add(outline, tileMap)

      assert.equals(outline, action.payload.outline)
      assert.equals(tileMap, action.payload.tileMap)
      assert.not_nil(action.type)
      assert.equals("MAP_ADD", action.type)
    end)
  end)

  describe("ACTION: create", function()
    local generator = spy.new(function() return {} end)

    before_each(function()
      mockDispatch:reset()
      mockDispatch.processComplex = true
    end)

    it("uses a generator to create the map", function()
      mockDispatch(Actions.create(100, 100, generator))
      assert.spy(generator).was.called_with(100, 100, 10)
    end)

    it("is defined as the MAP_CREATE thunk", function()
      local c = Actions.create(30, 20, function() end)
      assert.equals("MAP_CREATE", c.type)
    end)

    it("sets the map dimensions", function()
      local action = Actions.create(30, 20, generator)
      assert.thunk_dispatches(Actions.setDimensions(30, 20, 10), action)
    end)
  end)

  describe("ACTION: addRoom", function()
    it("describes a room that should be added to the map", function()
      local room = {}
      local action = Actions.addRoom(room)
      assert.equals("MAP_ADD_ROOM", action.type)
      assert.equals(room, action.payload.room)
    end)
  end)

  describe("ACTION: addCorridor", function()
    it("describes a new corridor to add to the map", function()
      local corridor = {}
      local action = Actions.addCorridor(corridor)
      assert.equals("MAP_ADD_CORRIDOR", action.type)
      assert.equals(corridor, action.payload.corridor)
    end)
  end)

  describe("ACTION: setDimensions", function()
    it("describes the expected dimensions for the map", function()
      local action = Actions.setDimensions(100, 123, 18)
      assert.equals("MAP_SET_DIMENSIONS", action.type)
      assert.equals(100, action.payload.width)
      assert.equals(123, action.payload.height)
      assert.equals(18, action.payload.levels)
    end)
  end)

  describe("ACTION: setTileProperties", function()
    it("describes a tile that should be set to specific values", function()
      local action = Actions.setTileProperties(Position(2, 3, 2), { terrain = "terrain", trigger = "something" })
      assert.equals("MAP_SET_TILE_PROPERTIES", action.type)
      assert.equals(Position(2, 3, 2), action.payload.position)
      assert.equals("terrain", action.payload.properties.terrain)
      assert.equals("something", action.payload.properties.trigger)
    end)
  end)

  describe("ACTION: populate", function()
    it("populates the map depending on what should be living there", function()
      mockStore({
        map = {
          rooms = {
            { x = 5, y = 10, level = 5,  width = 10, height = 10 }
          }
        }
      })
      assert.thunk_dispatches_type("ENTITY_ADD", Actions.populate())
    end)
  end)
end)