-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return function(state)
  assert(state.characters)
  return tables.find_first(state.characters,
    function(c)
      return c.is_player_controlled
    end
  )
end