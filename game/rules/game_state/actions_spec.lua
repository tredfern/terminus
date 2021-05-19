-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions", function()
  local Actions = require "game.rules.game_state.actions"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local app = require "game.app"
  local character = require "game.rules.character"
  local Map = require "game.rules.map"

  describe("ACTIONS: checkGameOver", function()
    setup(function()
      mockDispatch.processComplex = true
    end)

    teardown(function()
      mockDispatch.processComplex = false
    end)

    before_each(function()
      mock(app)
      app.gameOver:clear()
    end)


    it("triggers the game over action if the player has zero health", function()
      mockStore({
        characters = {
          { isPlayerControlled = true, health = 0 }
        }
      })

      local action = Actions.checkGameOver()
      mockDispatch(action)

      assert.spy(app.gameOver).was.called()
    end)

    it("triggers the game over action if the player does not exist in the characters state", function()
      mockStore({ characters = { {}, {} } }) -- adding a couple "placeholder" characters so not empty

      mockDispatch(Actions.checkGameOver())

      assert.spy(app.gameOver).was.called()
    end)

    it("triggers the game over action if their are no spawners left on the map", function()
      -- spawner around
      mockStore({
        characters = { { isPlayerControlled = true, health = 10 } },
        world = { { spawner = true } }
      })

      local action = Actions.checkGameOver()
      mockDispatch(action)
      assert.spy(app.gameOver).was.not_called()

      -- spawner not around
      mockStore({
        characters = { { isPlayerControlled = true, health = 10 } },
        world = { { } }
      })
      mockDispatch(action)

      assert.spy(app.gameOver).was.called()
    end)
  end)

  describe("ACTION: gameOver", function()
    it("returns to the title screen", function()
      mock(app)
      local go = Actions.gameOver()
      go()
      assert.spy(app.gameOver).was.called()
    end)
  end)

  describe("ACTION: loadCoreData", function()
    before_each(function()
      local action = Actions.loadCoreData()
      action()
    end)

    it("loads the core skills", function()
      local Skills = require "game.rules.skills"
      assert.not_nil(Skills.list.handgun)
      assert.not_nil(Skills.list.blade)
    end)

    it("loads the core terrains", function()
      local Terrain = require "game.rules.map.terrain"
      assert.not_nil(Terrain.list.room)
      assert.not_nil(Terrain.list.corridor)
    end)
  end)

  describe("ACTION: setup", function()
    before_each(function()
      mockStore {
        map = {
          outline = {
            rooms = {
              { x = 1, y = 1, width = 10, height = 10 }
      } } } }
    end)

    it("dispatch create character action for player character", function()
      assert.thunk_dispatches(Actions.setup(), function(a)
        return a.type == character.actions.types.ADD and
          a.payload.character.isPlayerControlled
      end)
    end)

    it("adds some random enemies spawners", function()
      assert.thunk_dispatches(Actions.setup(), function(c) return
        c.type == "ENTITY_ADD" and c.payload.entity.spawner
      end)
    end)

    it("creates a map", function()
      assert.thunk_dispatches_type(Actions.setup(), Map.actions.types.CREATE)
    end)
  end)

  describe("ACTION: updateFrame", function()
    it("is has a type of update frame", function()
      local action = Actions.updateFrame(12)
      assert.equals("GAME_STATE_UPDATE_FRAME", action.type)
    end)

    it("updates graphics", function()
      assert.thunk_dispatches_type(Actions.updateFrame(), "GRAPHICS_UPDATE_FRAME")
    end)
  end)
end)