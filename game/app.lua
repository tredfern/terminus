-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
store.create_store(require "game.rules.reducers")

local app = {}
app.assets = require "assets"
app.actions = require "game.rules.actions"

local market_screen = require "game.ui.screens.market"

function app.load()
  app.render(market_screen())
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

store.dispatch(app.actions.new_game())

return app