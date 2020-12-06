-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local app = {}

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
end

moonpie.keyboard.hot_keys["escape"] = app.game_menu
return app