-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local cargo_adjust = require "game.rules.actions.cargo_adjust"
local player_has_cargo = require "game.rules.validators.player_has_cargo"

return function(name, _)
  return function(dispatch, get_state)
    local state = get_state()

    if player_has_cargo(state, name) then
      dispatch(cargo_adjust(name, -1))
    end
  end
end