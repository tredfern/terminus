-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Panel = require "game.ui.widgets.panel"
local introStory = require "assets.stories.intro"
local App = require "game.app"

local GameStart = Components("game_start_screen", function()
  return {
    id = "game_start_screen",
    Panel {
      style = "align-center align-middle",
      width = "50%",
      title = "The Beginning",
      contents = {
        { Components.text { style = "align-center", text = introStory.text }, margin = 10},
        Components.button {
          id = "btnStart", caption = "Start", click = App.mainScreen, style = "align-center button-primary"
        }
      }
    }
  }
end)


return GameStart