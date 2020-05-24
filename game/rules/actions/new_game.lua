-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


return function()
  local spaceport_add = require "game.rules.actions.spaceport_add"
  local location_update = require "game.rules.actions.location_update"

  return function(dispatch, get_state)
    dispatch(spaceport_add{ name = "Alpha Station" })
    dispatch(spaceport_add{ name = "Bravo Station" })
    dispatch(spaceport_add{ name = "Charlie Station" })
    dispatch(spaceport_add{ name = "Delta Station" })
    dispatch(spaceport_add{ name = "Echo Station" })


    dispatch(
      location_update(
        moonpie.tables.pick_random(get_state().spaceports)
      )
    )
  end
end