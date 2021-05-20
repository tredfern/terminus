-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions", function()
  local Actions = require "game.rules.map.actions"
  local Position = require "game.rules.world.position"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

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

    it("adds the map to the state", function()
      mockDispatch(Actions.create(100, 100, generator))
      assert.is_true(mockDispatch:received_action("MAP_ADD"))
    end)

    it("uses a generator to create the map", function()
      mockDispatch(Actions.create(100, 100, generator))
      assert.spy(generator).was.called_with(100, 100, 10)
    end)

    it("is defined as the MAP_CREATE thunk", function()
      local c = Actions.create(30, 20, function() end)
      assert.equals("MAP_CREATE", c.type)
    end)
  end)
end)