-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local store = require "game.store"
local Animator = require "game.rules.graphics.animator"
local Characters = require "game.rules.character"
local Inventory = require "game.rules.inventory"
local Items = require "game.rules.items"
local Position = require "game.rules.world.position"
local World = require "game.rules.world"
local characterIdle = require "assets.characters.character_idle"
local Door = require "game.rules.map.furniture.door"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"
local Selectors = require "game.rules.player.selectors"

local Actions = {}

Actions.types = require "game.rules.player.types"

function Actions.add(position)
  local c = Characters.create { position = position, isPlayerControlled = true }
  c.animator = Animator:new()
  c.animator:addAnimation("idle", characterIdle)
  c.animator:play("idle")
  c.sightRadius = 8
  return Characters.actions.add(c)
end

function Actions.equipItem(item)
  local player = Selectors.getPlayer(store.getState())
  return Inventory.actions.equipItem(player, item)
end

function Actions.ladderDown()
  return Thunk(Actions.types.LADDER_DOWN, function(dispatch, getState)
    local state = getState()
    local player = Selectors.getPlayer(state)
    local ladder = World.selectors.getByPosition(state, player.position, "ladderDown")[1]

    if ladder then
      dispatch(Actions.move(Position.down))
    end
  end)
end

function Actions.ladderUp()
  return Thunk(Actions.types.LADDER_UP, function(dispatch, getState)
    local state = getState()
    local player = Selectors.getPlayer(state)
    local ladder = World.selectors.getByPosition(state, player.position, "ladderUp")[1]

    if ladder then
      dispatch(Actions.move(Position.up))
    end
  end)
end

function Actions.move(direction)
  local Map = require "game.rules.map"
  return Thunk(Actions.types.MOVE, function(dispatch, getState)
    local state = getState()
    local player = Selectors.getPlayer(state)

    local newPos = direction(player.position)
    dispatch(Characters.actions.move(player, newPos))

    local newTile = Map.selectors.getTile(state, newPos)
    if newTile then
      dispatch(Actions.enteredRoom(newTile.room))
    end
  end)
end

function Actions.openDoor(orientation)
  return Thunk(
    Actions.types.openDoor,
    function(dispatch, getState)
      local player = Selectors.getPlayer(getState())
      local checkDoor = Position[orientation](player.position)
      local door = Door.selectors.getByPosition(getState(), checkDoor)

      if door then
        if door.locked then
          if Selectors.hasItemOfKind(getState(), "keycard") then
            dispatch(Door.actions.unlock(door))
            dispatch(MessageLog.actions.add(Messages.movement.door.unlocked))
          else
            dispatch(MessageLog.actions.add(Messages.movement.door.locked))
          end
        else
          dispatch(Door.actions.open(door))
        end
      end
    end
  )
end

function Actions.pickupItems()
  return function(dispatch, getState)
    local state = getState()
    local pc = Selectors.getPlayer(state)

    local items = Items.selectors.getByPosition(state, pc.position)
    for _, i in ipairs(items) do
      dispatch(Inventory.actions.addItem(pc, i))
      dispatch(Items.actions.remove(i))
    end
  end
end

function Actions.enteredRoom(room)
  if room == nil then return end

  return Thunk(
    Actions.types.ENTERED_ROOM,
    function(dispatch, getState)
      if Selectors.hasVisitedRoom(getState(), room) then return end
      dispatch(MessageLog.actions.add(room.description))
      dispatch(Actions.trackRoomVisit(room))
    end
  )
end

function Actions.trackRoomVisit(room)
  return {
    type = Actions.types.TRACK_ROOM_VISIT,
    payload = {
      room = room
    }
  }
end

return Actions