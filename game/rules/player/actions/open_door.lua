-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.player.actions.types"
local Position = require "game.rules.world.position"
local World = require "game.rules.world"
local getPlayer = require "game.rules.player.selectors.get_player"
local tables = require "moonpie.tables"


return function(orientation)
  return Thunk(
    actionTypes.openDoor,
    function(_, getState)
      local player = getPlayer(getState())
      local checkDoor = Position[orientation](player.position)
      local entities = World.selectors.getByPosition(getState(), checkDoor)

      local door = tables.findFirst(entities, function(e) return e.door end)
      if door and door.closed then
        door.animator:playOnce("opening")
        door.closed = false
        door.blocksMovement = false
        door.blocksSight = false
      end
    end
  )
end