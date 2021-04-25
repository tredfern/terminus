-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.player.actions.types"


return function(door)
  return Thunk(
    actionTypes.openDoor,
    function()
      door.animator:play("opening")
    end
  )
end