-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local app = require "game.app"
local Image = require "moonpie.graphics.image"
local events = require "moonpie.events"
local colors = require "moonpie.graphics.colors"
local audio = require "assets.sounds"

local c = colors(colors.light_shade)
local starField = love.graphics.newParticleSystem(Image.load("assets/graphics/particles/circle.png"))
  starField:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	starField:setEmissionRate(25)
  starField:setSizes(0.05, 0.1)
	starField:setSizeVariation(0.5)
	starField:setLinearAcceleration(-220, -220, 220, 220) -- Random movement in all directions.
	starField:setColors(c[1], c[2], c[3], 1, c[1], c[2], c[3], 0)
  starField:setEmissionArea("borderrectangle", 50, 50)
  starField:setTangentialAcceleration(10, 100)

events.beforeUpdate:add(function()
  local dt = love.timer.getDelta()
  starField:update(dt)
end)
local main_menu = components("main_menu", function()

  return panel {
    style = "main_menu panel_primary align-center align-middle",
    title = "terminus",
    contents = {
      components.button {
        id = "btnContinue",
        style = "main_menu_button",
        caption = "Continue",
        click = app.continue
      },
      components.button {
        id = "newGame_button",
        style = "main_menu_button",
        caption = "New Campaign",
        click = app.newGame
      },
      components.button {
        id = "btnAchievements",
        style = "main_menu_button",
        caption = "Achievements",
        click = app.achievements
      },
      components.button {
        id = "options_button",
        style = "main_menu_button",
        caption = "Options",
        click = function() app.options(app.title) end },
      components.button {
        style = "main_menu_button",
        caption = "Exit",
        click = app.quit
      },
    },


  }
end)

return components("title_screen", function()
  return {
    main_menu(),
    components.text {
      text = "Copyright 2021 Trevor Redfern | Devlog: wheretheredfern.codes | Source: github.com/tredfern/terminus",
      style = "align-bottom align-right",
      padding = 5
    },
    drawComponent = function(self)
      love.graphics.setColor({ 1, 1, 1, 1})
      love.graphics.draw(starField, self.box.width/ 2, self.box.height / 2)
    end,
    mounted = function()
      audio.titleTrack:play()
    end,
    unmounted = function()
      audio.titleTrack:stop()
    end
  }
end)