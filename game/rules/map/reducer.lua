-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.actions.types"

local function getTile(map, x, y)
  if map[x] == nil then
    map[x] = {}
  end
  if map[x][y] == nil then
    map[x][y] = {}
  end

  return map[x][y]
end

return create_slice {
  [types.ADD] = function(_, action)
    return action.payload
  end,
  [types.SET_TERRAIN] = function(state, action)
    local tile = getTile(action.payload.map, action.payload.x, action.payload.y)
    tile.terrain = action.payload.terrain
    return state
  end,
}