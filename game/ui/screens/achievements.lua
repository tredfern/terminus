-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local app = require "game.app"

local Achievements = Components("achievements_screen", function()
  return {
    id = "achievements_screen",
    Components.h1 { text = "Achievements" },
    Components.button { caption = "Back", click = app.title }
  }
end)

return Achievements