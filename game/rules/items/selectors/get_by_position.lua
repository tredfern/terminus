-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return function(state, x, y)
  return tables.select(state.items, function(item)
    return item.position == { x, y }
  end)
end