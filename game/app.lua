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
  app.splash()
  moonpie.events.afterUpdate:add(app.update)
end

function app.render(scene)
  Cache.clear()
  moonpie.render(moonpie.ui.components.body(scene))
  app.currentScreen = scene.name
end

-- Global Actions

function app.update()
  store.dispatch(game_state.actions.updateFrame(love.timer.getDelta()))
end

function app.quit()
  love.event.quit()
end

function app.saveGame()
  local serializer = require "game.serializer"
  serializer.save(saveGameName, store.getState())
end

-- Main Screens

function app.achievements()
  local achievements = require "game.ui.screens.achievements"
  app.render(achievements())
end

function app.continue()
  local serializer = require "game.serializer"
  local loadSave = serializer.load(saveGameName)

  store.reset(loadSave)
  app.combat()
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

function app.splash()
  local s = require "game.ui.screens.splash"
  app.render(s())
end

function app.title()
  store.reset()
  local t = require("game.ui.screens.title")
  app.render(t())
end

-- Game Screens
function app.gameStart()
  local gameStart = require "game.ui.screens.game_start"
  app.render(gameStart())
end

function app.gameOver()
  local gameOver = require "game.ui.screens.game_over"
  app.render(gameOver())
end

function app.combat()
  local combat = require "game.ui.screens.combat"
  app.render(combat())
end

-- Character Screens

function app.characterDetails()
  local CharacterDetails = require "game.ui.screens.character_details"
  app.render(CharacterDetails())
end

function app.inventory()
  local Inventory = require "game.ui.screens.inventory"
  app.render(Inventory())
end

function app.journal()
  local Journal = require "game.ui.screens.journal"
  app.render(Journal())
end

function app.worldMap()
  local WorldMap = require "game.ui.screens.world_map"
  app.render(WorldMap())
end

moonpie.keyboard:hotkey("escape", app.gameMenu)
return app