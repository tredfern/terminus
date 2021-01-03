-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local app = {}

local function set_up_the_game()
  store.create_store(require "game.rules.reducers", { })

  local character_add = require "game.rules.actions.character_add"
  local character = require "game.entities.character"

  store.dispatch(character_add(character:new{ x = 2, y = 1, is_player_controlled = true }))
  for _=1,4 do
    store.dispatch(character_add(character:new { is_enemy = true, x = math.random(10), y = math.random(10) }))
  end
end

function app.load()
  -- Load state machine
  local gsm = require "game.game_state_machine"
  gsm.initialize()

  -- Configure state store
  store.create_store(require "game.rules.reducers", { })
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
  local combat = require "game.ui.screens.combat"
  app.render(combat())
end

moonpie.keyboard.hot_keys["escape"] = app.game_menu
return app