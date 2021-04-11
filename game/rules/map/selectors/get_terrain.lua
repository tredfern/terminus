-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local terrain = require "game.rules.map.terrain"

return function(state, x, y)
  if state.map and state.map.tileMap then
    local tile = state.map.tileMap:getTile(x, y)
    if tile then return tile.terrain end
  end
  return terrain.list.blank
end