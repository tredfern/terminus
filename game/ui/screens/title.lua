-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local app = require "game.app"

local game_menu = components("game_menu", function()
  return panel {
    style = "main_menu panel_red align-center align-middle",
    title = "terminus",
    contents = {
      components.button {
        style = "main_menu_button",
        caption = "New Campaign",
        click = function()
          app.create_character()
        end
      },
      components.button { style = "main_menu_button", caption = "Options" },
      components.button {
        style = "main_menu_button",
        caption = "Exit",
        click = function() love.event.quit() end
      },
    }
  }
end)

return components("title_screen", function()
  return {
    game_menu()
  }
end)