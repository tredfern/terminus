-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local app = require "game.app"

return components("game_menu", function()
  local game_menu_instance
  game_menu_instance = {
    target_layer = "modal",
    style = "align-center align-middle",
    panel {
      style = "main_menu panel_primary align-center align-middle",
      title = "terminus",
      contents = {
        components.button {
          id = "btn_resume",
          style = "main_menu_button",
          caption = "Resume",
          click = function() game_menu_instance:remove() end
        },
        components.button {
          id = "btn_title_screen",
          style = "main_menu_button",
          caption = "Abandon Campaign",
          click = function()
            game_menu_instance:remove()
            app.title()
          end
        },
        components.button { style = "main_menu_button", caption = "Options" },
        components.button {
          id = "btn_quit",
          style = "main_menu_button",
          caption = "Exit",
          click = app.quit
        },
      }
    }
  }
  return game_menu_instance
end)