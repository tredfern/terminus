-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Thunk = require "moonpie.redux.thunk"
local store = require "game.store"
local Animator = require "game.rules.graphics.animator"
local Characters = require "game.rules.character"
local Position = require "game.rules.world.position"
local World = require "game.rules.world"
local characterIdle = require "assets.characters.character_idle"
local Door = require "game.rules.map.furniture.door"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"
local Cache = require "game.cache"

local Player = {
  actions = {},
  selectors = {}
}

Player.actions.types = {
  LADDER_DOWN = "PLAYER_LADDER_DOWN",
  LADDER_UP = "PLAYER_LADDER_UP",
  MOVE = "PLAYER_MOVE",
  OPEN_DOOR = "PLAYER_OPEN_DOOR"
}

function Player.actions.add(position)
  local c = Characters.create { position = position, isPlayerControlled = true }
  c.animator = Animator:new()
  c.animator:addAnimation("idle", characterIdle)
  c.animator:play("idle")
  c.sightRadius = 8
  return Characters.actions.add(c)
end

function Player.actions.equipItem(item)
  local player = Player.selectors.getPlayer(store.getState())
  return Characters.actions.equipItem(player, item)
end

function Player.actions.ladderDown()
  return Thunk(Player.actions.types.LADDER_DOWN, function(dispatch, getState)
    local state = getState()
    local player = Player.selectors.getPlayer(state)
    local ladder = World.selectors.getByPosition(state, player.position, "ladderDown")[1]

    if ladder then
      dispatch(Characters.actions.move(player, Position.down(player.position)))
    end
  end)
end

function Player.actions.ladderUp()
  return Thunk(Player.actions.types.LADDER_UP, function(dispatch, getState)
    local state = getState()
    local player = Player.selectors.getPlayer(state)
    local ladder = World.selectors.getByPosition(state, player.position, "ladderUp")[1]

    if ladder then
      dispatch(Characters.actions.move(player, Position.up(player.position)))
    end
  end)
end

function Player.actions.move(direction)
  return Thunk(Player.actions.types.MOVE, function(dispatch, getState)
    local player = Player.selectors.getPlayer(getState())

    local newPos = direction(player.position)
    dispatch(Characters.actions.move(player, newPos))
  end)
end

function Player.actions.openDoor(orientation)
  return Thunk(
    Player.actions.types.openDoor,
    function(dispatch, getState)
      local player = Player.selectors.getPlayer(getState())
      local checkDoor = Position[orientation](player.position)
      local door = Door.selectors.getByPosition(getState(), checkDoor)

      if door then
        if door.locked then
          if Player.selectors.hasItemOfKind(getState(), "keycard") then
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

function Player.actions.pickupItems()
  return function(dispatch, getState)
    local pc = Player.selectors.getPlayer(getState())

    dispatch(Characters.actions.pickupItems(pc))
  end
end

function Player.selectors.getPlayer(state)
  return Cache {
    name = "GET_PLAYER",
    source = function()
      local result = World.selectors.getAllWithComponents(state, "isPlayerControlled")
      return result[1]
    end
  }
end

function Player.selectors.hasItemOfKind(state, itemType)
  local p = Player.selectors.getPlayer(state)

  return tables.any(p.inventory, function(slot) return slot.item.key == itemType end)
end

function Player.selectors.getFieldOfView(state)
  local FOV = require "game.rules.field_of_view"

  local p = Player.selectors.getPlayer(state)
  return FOV.selectors.get(state, p)
end

return Player