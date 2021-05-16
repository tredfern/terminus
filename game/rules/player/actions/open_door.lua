-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.player.actions.types"
local Position = require "game.rules.world.position"
local getPlayer = require "game.rules.player.selectors.get_player"
local Door = require "game.rules.furniture.door"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"


return function(orientation)
  return Thunk(
    actionTypes.openDoor,
    function(dispatch, getState)
      local player = getPlayer(getState())
      local checkDoor = Position[orientation](player.position)
      local door = Door.selectors.getByPosition(getState(), checkDoor)

      if door then
        if door.locked then
          dispatch(MessageLog.actions.add(Messages.movement.door.locked))
        else
          dispatch(Door.actions.open(door))
        end
      end
    end
  )
end