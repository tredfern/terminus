-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local findFirst = require "moonpie.tables.find_first"

return function(state, x, y)
  if state == nil or state.map == nil or state.map.enemySpawners == nil then return nil end
  return findFirst(state.map.enemySpawners, function(v) return v.x == x and v.y == y end)
end