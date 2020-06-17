-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local trade_goods = require "assets.trade_goods"

return function()
  local message_add = require "game.rules.actions.message_add"
  local market_add_item = require "game.rules.actions.market_add_item"
  local spaceport_add = require "game.rules.actions.spaceport_add"
  local travel_to = require "game.rules.actions.travel_to"
  local money_update = require "game.rules.actions.money_update"

  return function(dispatch, get_state)
    dispatch(message_add("New Game!"))
    dispatch(spaceport_add{ name = "Alpha Station" })
    dispatch(spaceport_add{ name = "Bravo Station" })
    dispatch(spaceport_add{ name = "Charlie Station" })
    dispatch(spaceport_add{ name = "Delta Station" })
    dispatch(spaceport_add{ name = "Echo Station" })

    for _, v in ipairs(trade_goods) do
      dispatch(market_add_item(v.name, v.baseprice))
    end

    dispatch(money_update(500))

    dispatch(
      travel_to(
        moonpie.tables.pick_random(get_state().spaceports)
      )
    )
    dispatch(message_add("Going to market"))
  end
end