-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return function(state, ...)
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