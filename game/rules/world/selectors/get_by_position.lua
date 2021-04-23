-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Position = require "game.rules.world.position"

return function(state, position)
  local characters = state.characters or {}
  local items = state.items or {}
  local entities = state.world or {}

  local comparison = function(e)
    return Position.equal(e.position, position)
  end

  return tables.join(
    tables.select(characters, comparison),
    tables.select(items, comparison),
    tables.select(entities, comparison)
  )
end