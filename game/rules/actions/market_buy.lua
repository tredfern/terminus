-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local cargo_adjust = require "game.rules.actions.cargo_adjust"
local money_adjust = require "game.rules.actions.money_adjust"

return function(name, price)
  return function(dispatch, get_state)
    local state = get_state()
    assert(state.player.money, "State must have a player with money to buy something")

    if state.player.money >= price then
      dispatch(cargo_adjust(name, 1))
      dispatch(money_adjust(-price))
    end
  end
end