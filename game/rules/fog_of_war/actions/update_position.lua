-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.fog_of_war.actions.types"

return function(perspective, position, tile)
  local key = nil
  if type(position) == "number" then
    key = position
    position = nil
  end

  return {
    type = actionTypes.UPDATE_POSITION,
    payload = {
      perspective = perspective,
      position = position,
      positionHashKey = key,
      tile = tile
    }
  }
end