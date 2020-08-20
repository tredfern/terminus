-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"

return components("label_value", function(props)
  return {
    components.text { style = "label", text = props.label, id = "label" },
    components.text { style = "value", text = props.value, id = "value" },

    label = function() return props.label end,
    value = function() return props.value end
  }
end)