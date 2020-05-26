-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local trade_goods = require "assets.trade_goods"

return function()
  local cargo_update = require "game.rules.actions.cargo_update"
  local location_update = require "game.rules.actions.location_update"
  local market_add_item = require "game.rules.actions.market_add_item"
  local spaceport_add = require "game.rules.actions.spaceport_add"

  return function(dispatch, get_state)
    dispatch(spaceport_add{ name = "Alpha Station" })
    dispatch(spaceport_add{ name = "Bravo Station" })
    dispatch(spaceport_add{ name = "Charlie Station" })
    dispatch(spaceport_add{ name = "Delta Station" })
    dispatch(spaceport_add{ name = "Echo Station" })

    for _, v in ipairs(trade_goods) do
      dispatch(market_add_item(v.name, v.baseprice))
      dispatch(cargo_update(v.name, 0))
    end



    dispatch(
      location_update(
        moonpie.tables.pick_random(get_state().spaceports)
      )
    )
  end
end