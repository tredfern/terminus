-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local World = require "game.rules.world"
local calculate = require "game.rules.field_of_view.calculate"

local Actions = {}
Actions.types = require "game.rules.field_of_view.types"

function Actions.calculateAll()
  return Thunk(
    Actions.types.CALCULATE_ALL,
    function(dispatch, getState)
      local entities = World.selectors.getAllWithComponents(getState(), "sightRadius", "position")

      for _, v in ipairs(entities) do
        dispatch(Actions.calculate(v, v.position, v.sightRadius))
      end
    end
  )
end

function Actions.calculate(entity, position, radius)
  return Thunk(
    Actions.types.CALCULATE,
    function(dispatch, getState)
      local vm = calculate(getState(), position, radius)
      dispatch(Actions.update(entity, vm))
    end
  )
end

function Actions.update(entity, visibilityMap)
  return {
    type = Actions.types.UPDATE,
    payload = {
      entity = entity,
      visibilityMap = visibilityMap
    }
  }
end

return Actions