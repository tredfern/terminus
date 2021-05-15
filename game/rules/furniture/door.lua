-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Animator = require "game.rules.graphics.animator"
local store = require "game.store"
local World = require "game.rules.world"
local Thunk = require "moonpie.redux.thunk"
local Graphics = require "game.rules.graphics"

local Door = {
  actions = {},
  selectors = {},
  images = require "assets.maps.features.doors"
}

local function validateAdd(position)
  local entities = World.selectors.getByPosition(store.getState(), position)
  return not tables.any(entities, function(e) return e.door end)
end

local function createAnimation(orientation)
  local a = Animator:new()
  a:addAnimation("opening", Door.images[orientation].opening)
  return a
end

function Door.actions.add(position, orientation)
  if not validateAdd(position) then
    return nil
  end

  local entity = {
    sprite = Door.images[orientation].closed,
    position = position,
    door = true,
    closed = true,
    blocksMovement = true,
    blocksSight = true,
    orientation = orientation,
    animator = createAnimation(orientation)
  }

  return World.actions.addEntity(entity)
end

function Door.actions.open(door)
  return Thunk(
    "DOOR_OPEN",
    function(dispatch)
      local updateChanges = {
        closed = false,
        blocksMovement = false,
        blocksSight = false
      }

      dispatch(World.actions.updateEntity(door, updateChanges))
      dispatch(Graphics.actions.animationPlayOnce(door.animator, "opening"))
    end,
    function()
      return door.closed and not door.locked
    end
  )
end

return Door