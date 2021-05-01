-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.field_of_view.actions.types"
local calculate = require "game.rules.field_of_view.calculate"
local update = require "game.rules.field_of_view.actions.update"


return function(entity, position, radius)
  return Thunk(
    actionTypes.CALCULATE,
    function(dispatch, getState)
      local vm = calculate(getState(), position, radius)
      dispatch(update(entity, vm))
    end
  )
end