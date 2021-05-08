-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.stylesheet"
local store = require "game.store"
local game_state = require "game.rules.game_state"
local Cache = require "game.cache"
local app = {}
local saveGameName = "game.dat"

function app.load()
  local keyboard = require "moonpie.keyboard"
  keyboard:hotkey("f10", store.dumpState)
  store.dispatch(game_state.actions.loadCoreData())
  app.title()
  moonpie.events.afterUpdate:add(app.update)
end

function app.update()
  store.dispatch(game_state.actions.updateFrame(love.timer.getDelta()))
end

function app.render(scene)
  Cache.clear()
  moonpie.render(moonpie.ui.components.body(scene))
  app.currentScreen = scene.name
end

function app.title()
  store.reset()
  local t = require("game.ui.screens.title")
  app.render(t())
end

function app.quit()
  love.event.quit()
end

function app.gameMenu()
  local t = require("game.ui.widgets.game_menu")
  moonpie.render(t(), "modal")
end

function app.newGame()
  store.dispatch(game_state.actions.setup())
  local create_character = require "game.ui.screens.create_character"
  app.render(create_character())
end

function app.options(returnScreen)
  local options = require "game.ui.screens.options"
  app.render(options({ returnScreen = returnScreen }))
end

function app.combat()
  local combat = require "game.ui.screens.combat"
  app.render(combat())
end

function app.characterDetails()
  local CharacterDetails = require "game.ui.screens.character_details"
  app.render(CharacterDetails())
end

function app.continue()
  local serializer = require "game.serializer"
  local loadSave = serializer.load(saveGameName)

  store.reset(loadSave)
  app.combat()
end

function app.saveGame()
  local serializer = require "game.serializer"
  serializer.save(saveGameName, store.getState())
end

function app.gameOver()
  local gameOver = require "game.ui.screens.game_over"
  app.render(gameOver())
end

moonpie.keyboard:hotkey("escape", app.gameMenu)
return app