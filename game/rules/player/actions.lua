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

function Actions.clearHotKey(hotkey)
  return {
    type = Actions.types.CLEAR_HOT_KEY,
    payload = {
      hotkey = hotkey
    }
  }
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

      if Items.isUsable(i) then
        local freeHotKey = Selectors.getFreeHotKey(getState())
        if freeHotKey then
          dispatch(Actions.setHotKey(freeHotKey, i.name, i.sprite, function()
            -- This should be a custom Thunk
            store.dispatch(Items.actions.use(i, pc))
            store.dispatch(Actions.clearHotKey(freeHotKey))
          end))
        end
      end
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

function Actions.rangedAttack(position)
  return Thunk(
    Actions.types.RANGED_ATTACK,
    function(dispatch, getState)
      local Combat = require "game.rules.combat"

      local pc = Selectors.getPlayer(getState())
      local targets = Characters.selectors.getByPosition(getState(), position)
      if #targets > 0 then
        dispatch(Combat.actions.rangedAttack(pc, targets[1]))
      end
    end
  )
end

function Actions.setHotKey(key, name, image, handler)
  return {
    type = Actions.types.SET_HOT_KEY,
    payload = {
      hotkey = key,
      name = name,
      image = image,
      handler = handler
    }
  }
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