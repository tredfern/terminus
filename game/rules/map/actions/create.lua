-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local thunk = require "moonpie.redux.thunk"
local addMap = require "game.rules.map.actions.add"
local actionTypes = require "game.rules.map.actions.types"

return function(width, height, generator)
  return thunk(
    actionTypes.CREATE,
    function(dispatch)
      local outline, tileMap = generator(width, height)
      dispatch(addMap(outline, tileMap))
    end
  )
end