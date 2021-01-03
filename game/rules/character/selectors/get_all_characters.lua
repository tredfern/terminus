-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return function(state)
  if not state.characters then
    return {}
  end

  return tables.select(state.characters, function() return true end)
end