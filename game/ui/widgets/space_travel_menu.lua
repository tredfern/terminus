-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


moonpie.ui.components("space_travel_menu", function(props)
  return {
    id = "space_travel_menu",
    moonpie.ui.components.h2 { text = "Destination" },
    moonpie.utility.tables.map(props.destinations, function(d)
      return moonpie.ui.components.button {
        id = "goto_{{name}}_button",
        caption = d.name,
        name = d.name,
        style = "destination_button",
        click = function()
          --rules.space_travel_to(d)
        end
      }
    end)
  }
end)