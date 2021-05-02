-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.fog_of_war.actions.types"
local FieldOfView = require "game.rules.field_of_view"
local updatePosition = require "game.rules.fog_of_war.actions.update_position"
local Map = require "game.rules.map"

return function(perspective)
  return Thunk(
    actionTypes.UPDATE_PERSPECTIVE,
    function(dispatch, getState)
      local state = getState()
      local visiblePoints = FieldOfView.selectors.getVisiblePositions(state, perspective)

      if visiblePoints then
        for _, pos in ipairs(visiblePoints) do
          local tile = Map.selectors.getTile(state, pos)
          dispatch(updatePosition(perspective, pos, tile))
        end
      end
    end
  )
end