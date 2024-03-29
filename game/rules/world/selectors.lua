-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Position = require "game.rules.world.position"
local Selectors = {}

function Selectors.getAllWithComponents(state, ...)
  local characters = state.characters or {}
  local items = state.items or {}
  local world = state.world or {}

  local components = tables.pack(...)

  local comparison = function(entity)
    return tables.all(components, function(c) return entity[c] end)
  end

  return tables.join(
    tables.select(characters, comparison),
    tables.select(items, comparison),
    tables.select(world, comparison)
  )
end

function Selectors.getByPosition(state, position, ...)
  local characters = state.characters or {}
  local items = state.items or {}
  local entities = state.world or {}
  local components = tables.pack(...)

  local comparison = function(e)
    return Position.equal(e.position, position)
      and tables.all(components, function(c) return e[c] end)
  end

  return tables.join(
    tables.select(characters, comparison),
    tables.select(items, comparison),
    tables.select(entities, comparison)
  )
end

return Selectors