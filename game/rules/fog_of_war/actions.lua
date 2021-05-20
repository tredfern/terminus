-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local FieldOfView = require "game.rules.field_of_view"
local Map = require "game.rules.map"

local Actions = {}

Actions.types = require "game.rules.fog_of_war.types"

function Actions.updatePerspective(perspective)
  return Thunk(
    Actions.types.UPDATE_PERSPECTIVE,
    function(dispatch, getState)
      local state = getState()
      local visiblePoints = FieldOfView.selectors.getVisiblePositions(state, perspective)

      if visiblePoints then
        for _, pos in ipairs(visiblePoints) do
          local tile = Map.selectors.getTile(state, pos)
          dispatch(Actions.updatePosition(perspective, pos, tile))
        end
      end
    end
  )
end

function Actions.updatePosition(perspective, position, tile)
  local key = nil
  if type(position) == "number" then
    key = position
    position = nil
  end

  return {
    type = Actions.types.UPDATE_POSITION,
    payload = {
      perspective = perspective,
      position = position,
      positionHashKey = key,
      tile = tile
    }
  }
end

return Actions