-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"

local title = components("spaceport_title", function(props)
  return {
    location_name = props.location_name,
    render = function(self)
      return moonpie.ui.components.h1 { id = "location_title_label", text = self.location_name }
    end
  }
end)

return connect(title, function(state) return { location_name = state.location.name } end)