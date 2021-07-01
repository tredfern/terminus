-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  -- App is the central glue module that loads up the modules and links things together
  local app = require "game.app"
  local testStates = require "test_helpers.test_states"


  it("loads the core data", function()
    local gameState = require "game.rules.game_state"
    spy.on(gameState.actions, "loadCoreData")
    app.load()

    assert.spy(gameState.actions.loadCoreData).was.called()
  end)

  it("can render scenes", function()
    app.render({ id = "foo" })
    assert.not_nil(moonpie.ui.current.findByID("foo"))
  end)

  describe("splash", function()
    it("can display the splash screen", function()
      app.splash()
      assert.not_nil(moonpie.ui.current.findByID("splash_screen"))
    end)
  end)

  describe("starting a new game", function()
    it("can start a new game", function()
      assert.has_no_errors(function() app.newGame() end)
    end)

    it("renders the create character screen", function()
      app.newGame()
      assert.not_nil(moonpie.ui.current.findByID("createCharacterScreen"))
    end)
  end)

  describe("main screen", function()
    it("renders the main screen", function()
      app.mainScreen()
      assert.not_nil(moonpie.ui.current.findByID("main_screen"))
    end)
  end)

  describe("game over screen", function()
    it("renders the game over screen", function()
      app.gameOver()
      assert.not_nil(moonpie.ui.current.findByID("gameOverScreen"))
    end)
  end)

  it("can show an option screen with the right return screen", function()
    local returnScreen = function() end
    app.options(returnScreen)
    assert.not_nil(moonpie.ui.current.findByID("options_screen"))
    assert.equals(returnScreen, moonpie.ui.current.findByID("btnClose").click)
  end)

  it("can show the character details screen", function()
    app.characterDetails()
    assert.not_nil(moonpie.ui.current.findByID("character_details_screen"))
  end)

  it("tracks the current state", function()
    app.mainScreen()
    assert.equals("main_screen", app.currentScreen)
    app.characterDetails()
    assert.equals("character_details", app.currentScreen)
  end)

  describe("continue save game", function()
    it("retrieves save game data from the serializer", function()
      local serializer = require "game.serializer"
      mock(serializer, "load")

      app.continue()
      assert.spy(serializer.load).was.called_with("game.dat")
    end)

    it("sets the store state to the loaded state", function()
      local serializer = require "game.serializer"

      local state = {}

      local old = serializer.load
      serializer.load = function() return state end

      local store = require "game.store"
      spy.on(store, "reset")

      stub(app, "mainScreen")
      app.continue()
      app.mainScreen:revert()
      assert.spy(store.reset).was.called_with(state)
      serializer.load = old
    end)
  end)

  describe("world map", function()
    it("shows the world map", function()
      testStates.basicGameState()
      app.worldMap()
      assert.not_nil(moonpie.ui.current.findByID("world_map"))
    end)
  end)

  describe("achievements", function()
    it("shows the achievements", function()
      app.achievements()
      assert.not_nil(moonpie.ui.current.findByID("achievements_screen"))
    end)
  end)

  describe("gameStart", function()
    it("shows the game start screen", function()
      app.gameStart()
      assert.not_nil(moonpie.ui.current.findByID("game_start_screen"))
    end)
  end)

  describe("characterInventory", function()
    it("shows the inventory screen", function()
      testStates.basicGameState()
      app.inventory()
      assert.not_nil(moonpie.ui.current.findByID("inventory_screen"))
    end)
  end)

  describe("characterJournal", function()
    it("shows the journal screen", function()
      app.journal()
      assert.not_nil(moonpie.ui.current.findByID("journal_screen"))
    end)
  end)

end)