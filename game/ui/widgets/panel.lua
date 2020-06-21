-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"

return components("panel", function(props)
  return {
    components.h3 { id = "panel_title", text = props.title },
    moonpie.ui.components.hr(),
    {
      id = "panel_contents",
      style = "panel_contents",
      props.contents
    }
  }
end)