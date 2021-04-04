-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local thunk = require "moonpie.redux.thunk"
local setMap = require "game.rules.map.actions.set"
local actionTypes = require "game.rules.map.actions.types"

return function(width, height, generator)
  return thunk(
    actionTypes.CREATE,
    function(dispatch)
      local newMap = generator(width, height)
      dispatch(setMap(newMap))
    end
  )
end