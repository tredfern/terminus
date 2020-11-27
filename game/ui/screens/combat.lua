-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local title = require "game.ui.widgets.section_title"
local message_log = require "game.ui.widgets.message_log"
local panel = require "game.ui.widgets.panel"
local tactical_display = require "game.ui.widgets.tactical_display"

return components("combat", function()
  return {
    title{ title = "Combat", style = "panel_red" }, {
      style = "sidebar",
      panel {
        style = "stretch_height",
        title = "Message Log",
        contents = message_log()
      },
    },
    {
      style = "primary",
      panel {
        title = "Tactical Display",
        contents = tactical_display()
      }
    }
  }
end)