-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Position = require "game.rules.world.position"

return function(state, x, y)
  return tables.select(state.characters, function(c)
    return Position.equal(c.position, { x = x, y = y })
  end)
end
