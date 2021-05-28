-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

return Components("button_bar", function(props)
  local c = {}
  if props.buttons then
    for _, btn in ipairs(props.buttons) do
      btn:addStyle("button_bar_button")
      table.insert(c, btn)
    end
  end
  return c
end)