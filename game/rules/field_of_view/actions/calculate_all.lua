-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.field_of_view.actions.types"
local Thunk = require "moonpie.redux.thunk"
local World = require "game.rules.world"
local calculate = require "game.rules.field_of_view.actions.calculate"

return function()
  return Thunk(
    actionTypes.CALCULATE_ALL,
    function(dispatch, getState)
      local entities = World.selectors.getAllWithComponents(getState(), "sightRadius", "position")

      for _, v in ipairs(entities) do
        dispatch(calculate(v, v.position, v.sightRadius))
      end
    end
  )
end