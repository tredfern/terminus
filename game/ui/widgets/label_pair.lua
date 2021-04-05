-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

return Components("labelPair", function(props)
  props.id = props.id or ""
  return {
    Components.text { id = props.id .. "Label", text = props.label },
    Components.text { id = props.id .. "Value", text = props.value, style ="align-right" }
  }
end)