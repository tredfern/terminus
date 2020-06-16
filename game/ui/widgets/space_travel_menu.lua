-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local connect = require "moonpie.redux.connect"
local travel_to = require "game.rules.actions.travel_to"

local menu = moonpie.ui.components("space_travel_menu", function(props)
  return {
    id = "space_travel_menu",
    destinations = props.destinations,
    render = function(self)
      return moonpie.utility.tables.map(self.destinations, function(d)
          return moonpie.ui.components.button {
            id = "goto_{{name}}_button",
            caption = d.name,
            name = d.name,
            style = "destination_button",
            click = function()
              self.dispatch(travel_to(d))
            end
          }
      end)
    end
  }
end)

return connect(menu, function(state) return { destinations = state.spaceports } end)