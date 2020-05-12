-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



moonpie.ui.components("main_layout", function(props)
  return {
    moonpie.ui.components.h1 { text = props.spaceport.name },
    moonpie.ui.components.hr(),
    moonpie.ui.components.market { market = props.spaceport, cargo_hold = props.player.cargo_hold },
    moonpie.ui.components.space_travel_menu {
      destinations = props.destinations
    }
  }
end)