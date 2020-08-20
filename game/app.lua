-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local attribute = require "game.entities.character.attribute"
local store = require "moonpie.redux.store"
store.create_store(require "game.rules.reducers", {
  player = {
    name = "Cmdr. Oskar",
    attributes = {
      strength = attribute(10),
      dexterity = attribute(10),
      endurance = attribute(10),
      intelligence = attribute(10),
      knowledge = attribute(10),
      personality = attribute(10)
    }
  }
})

local app = {}
app.assets = require "assets"
app.actions = require "game.rules.actions"

function app.load()
  app.title()
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

function app.create_character()
  local c = require("game.ui.screens.character_creation")
  app.render(c())
end

function app.game()
  store.dispatch(app.actions.new_game())
  local g = require("game.ui.screens.main_layout")
  app.render(g())
end

function app.title()
  local t = require("game.ui.screens.title")
  app.render(t())
end

return app