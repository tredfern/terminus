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
  app.show_story(app.assets.stories[1])
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

function app.show_story(story)
  local story_screen = require("game.ui.screens.story")
  app.render(story_screen { story = story })
end

moonpie.keyboard.hot_keys["escape"] = app.game_menu
return app