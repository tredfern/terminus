-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"
local cargo_entity = require "game.entities.cargo"

local function clone_cargo(name, state)
  local cargo = state[name] or {}
  local quantity = cargo.quantity or 0
  return cargo_entity(name, quantity)
end

return function(state, action)
  state = state or {}
  if not action then return state end

  if action.type == types.cargo_update then
    local cargo = clone_cargo(action.payload.name, state)
    cargo.quantity = action.payload.quantity
    return tables.assign({}, state, {
      [action.payload.name] = cargo
    })
  end

  if action.type == types.cargo_adjust then
    local cargo = clone_cargo(action.payload.name, state)
    cargo.quantity = cargo.quantity + action.payload.amount
    return tables.assign({}, state, {
      [action.payload.name] = cargo
    })
  end

  return state
end