-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, x, y)
  local map = state.map

  return map:getNeighbors(x, y)
end