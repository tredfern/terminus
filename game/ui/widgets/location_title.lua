-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local section_title = require "game.ui.widgets.section_title"

local title = components("spaceport_title", function(props)
  return {
    location_name = props.location_name,
    render = function(self)
      return section_title { id = "location_title", title = self.location_name }
    end
  }
end)

return connect(title, function(state) return { location_name = state.location.name } end)