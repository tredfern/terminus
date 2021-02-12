-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  -- App is the central glue module that loads up the modules and links things together
  local app = require "game.app"


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

  describe("starting a new game", function()
    it("can start a new game", function()
      assert.has_no_errors(function() app.newGame() end)
    end)

    it("renders the create character screen", function()
      app.newGame()
      assert.not_nil(moonpie.ui.current.findByID("create_character_screen"))
    end)
  end)

  describe("combat screen", function()
    it("renders the combat screen", function()
      app.combat()
      assert.not_nil(moonpie.ui.current.findByID("combat_screen"))
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
    app.combat()
    assert.equals("combat_screen", app.currentScreen)
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
      mock(store, "reset")

      stub(app, "combat")
      app.continue()
      app.combat:revert()
      assert.spy(store.reset).was.called_with(state)
      serializer.load = old
    end)
  end)

end)