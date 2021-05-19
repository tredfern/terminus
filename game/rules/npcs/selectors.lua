-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local tables = require "moonpie.tables"
local Selectors = {}

function Selectors.getEnemies(state)
  return tables.select(state.characters, function(c)
    return not c.isPlayerControlled
  end)
end

return Selectors