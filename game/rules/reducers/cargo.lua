-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

local function clone_cargo(name, state)
  local quantity = 0
  local c = tables.find_first(state, function(c) return c.name == name end)
  if c then quantity = c.quantity end
  return {
    name = name,
    quantity = quantity
  }
end

local function swapped_cargo(cargo, state)
  local found = false
  local swp = tables.map(state, function(c)
    if c.name == cargo.name then
      found = true
      return cargo
    end

    return c
  end)

  if not found then
    table.insert(swp, cargo)
  end

  return swp
end

return function(state, action)
  state = state or {}
  if not action then return state end

  if action.type == types.cargo_update then
    local cargo = clone_cargo(action.payload.name, state)
    cargo.quantity = action.payload.quantity
    return swapped_cargo(cargo, state)
  end

  if action.type == types.cargo_adjust then
    local cargo = clone_cargo(action.payload.name, state)
    cargo.quantity = cargo.quantity + action.payload.amount
    return swapped_cargo(cargo, state)
  end

  return state
end