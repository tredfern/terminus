-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local types = require "game.rules.actions.types"
local tables = moonpie.utility.tables

local function initial_state()
  return {
    spaceports = {},
    location = { name = "Unknown" },
    player_cargo = { },
    market_items = { }
  }
end

return function(state, action)
  state = state or initial_state()
  if not action then
    return state
  end

  if action.type == types.spaceport_add then
    return tables.assign({}, state, {
      spaceports = tables.concat_array(state.spaceports, { action.payload })
    })
  end

  if action.type == types.location_update then
    return tables.assign({}, state, {
      location = action.payload
    })
  end

  if action.type == types.cargo_update then
    local new_cargo = true
    local player_cargo = tables.map(state.player_cargo, function(c)
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

    return tables.assign({}, state, { player_cargo = player_cargo })
  end

  if action.type == types.market_add_item then
    local new_item = true
    local market_items = tables.map(state.market_items, function(mi)
      if mi.name == action.payload.name then
        new_item = false
        return { name = mi.name, price = action.payload.price }
      end
      return mi
    end)

    if new_item then
      market_items = tables.concat_array(
        market_items,
        { { name = action.payload.name, price = action.payload.price }}
      )
    end

    return tables.assign({}, state, { market_items = market_items })
  end

  return state
end