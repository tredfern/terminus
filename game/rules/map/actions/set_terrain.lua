-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.map.actions.types"

return function(map, x, y, terrain)
  return {
    type = actionTypes.SET_TERRAIN,
    payload = {
      map = map,
      x = x,
      y = y,
      terrain = terrain
    }
  }
end