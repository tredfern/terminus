-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.stylesheet"
local store = require "game.store"
local game_state = require "game.rules.game_state"
local app = {}

function app.load()
  app.title()
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
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
  moonpie.render("modal", t())
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

moonpie.keyboard:hotkey("escape", app.gameMenu)
return app