-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Position = require "game.rules.world.position"

return function(state, x, y)
  return tables.select(state.items, function(item)
    return Position.equal(item.position, { x, y })
  end)
end