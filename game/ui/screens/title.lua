-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local app = require "game.app"

local main_menu = components("main_menu", function()
  return panel {
    style = "main_menu panel_primary align-center align-middle",
    title = "terminus",
    contents = {
      components.button {
        id = "new_game_button",
        style = "main_menu_button",
        caption = "New Campaign",
        click = app.new_game
      },
      components.button { style = "main_menu_button", caption = "Options" },
      components.button {
        style = "main_menu_button",
        caption = "Exit",
        click = app.quit
      },
    }
  }
end)

return components("title_screen", function()
  return {
    main_menu()
  }
end)