-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, position)
  if state.map and state.map.tileMap then
    return state.map.tileMap:getTile(position)
  end
end