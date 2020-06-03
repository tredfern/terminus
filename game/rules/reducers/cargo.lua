-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

return function(state, action)
  state = state or {}
  if not action then return state end

  if action.type == types.cargo_update then
    local new_cargo = true
    local player_cargo = tables.map(state, function(c)
      if c.name == action.payload.name then
        new_cargo = false
        return { name = c.name, quantity = action.payload.quantity }
      end
      return c
    end)

    if new_cargo then
      player_cargo = tables.concat_array(
        player_cargo,
        { { name = action.payload.name, quantity = action.payload.quantity } }
      )
    end

    return tables.assign({}, state, player_cargo)
  end

  return state
end