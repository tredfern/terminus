-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local app = require "game.app"
local components = require "moonpie.ui.components"
local title = require "game.ui.widgets.section_title"
local character_general = require "game.ui.widgets.character.general"
local character_attributes = require "game.ui.widgets.character.attributes"
local panel = require "game.ui.widgets.panel"

return components("character_creation_screen", function()
  return {
    title({
      title = "Create Character",
      actions = {
        components.button { caption = "Done", style = "section_title_button", click = app.game }
      }
    }),
    panel({
      title = "Overview",
      contents = character_general(),
      style = "character_panel_general"
    }),
    panel({
      title = "Attributes",
      contents = character_attributes(),
      style = "character_panel_overview"
    })
  }
end)