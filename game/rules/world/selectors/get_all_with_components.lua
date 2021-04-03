-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

local function findComponents(entity, components)
  return tables.all(components, function(c) return entity[c] ~= nil end)
end

return function(state, ...)
  if state.characters == nil or state.items == nil then return {} end
  local components = tables.pack(...)

  return tables.join(
    tables.select(state.characters, function(entity)
      return tables.all(components, function(c) return entity[c] ~= nil end)
    end),
    tables.select(state.items, function(entity)
      return tables.all(components, function(c) return entity[c] ~= nil end)
    end)
  )
end