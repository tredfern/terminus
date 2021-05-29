-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local ButtonBar = Components("button_bar", function(props)
  local c = {}
  if props.buttons then
    for _, btn in ipairs(props.buttons) do
      btn:addStyle("button_bar_button")
      table.insert(c, btn)
    end
  end
  return c
end)

local Title = Components("full_screen_panel_title", function(props)
  return {
    Components.text {
      text = props.title,
      id = "full_screen_panel_title_text",
      style = "full_screen_panel_title_text"
    },
    ButtonBar { buttons = props.actions }
  }
end)

return Components("full_screen_panel", function(props)
  return {
    Title { title = props.title, id = "full_screen_panel_title", actions = props.actions },
    {
      id = "full_screen_panel_contents",
      style = "full_screen_panel_contents",
      props.contents
    }
  }
end)