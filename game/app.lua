-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "game.store"
local app = {}

local function set_up_the_game()
  local character = require "game.rules.character"

  store.dispatch(character.actions.add(character.create { x = 2, y = 1, is_player_controlled = true }))
  for _=1,4 do
    store.dispatch(
      character.actions.add(
        character.create { is_enemy = true, x = math.random(10), y = math.random(10) }))
  end
end

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
  local t = require("game.ui.screens.title")
  app.render(t())
end

function app.quit()
  love.event.quit()
end

function app.game_menu()
  local t = require("game.ui.widgets.game_menu")
  moonpie.render("modal", t())
end

function app.new_game()
  set_up_the_game()
  local create_character = require "game.ui.screens.create_character"
  app.render(create_character())
end

function app.combat()
  local combat = require "game.ui.screens.combat"
  app.render(combat())
end

moonpie.keyboard.hot_keys["escape"] = app.game_menu
return app