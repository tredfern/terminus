-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addEntity = require "game.rules.world.actions.add_entity"
local doors = require "assets.maps.features.doors"
local Animator = require "game.rules.graphics.animator"
local store = require "game.store"
local World = require "game.rules.world"
local tables = require "moonpie.tables"

local function validateAction(position)
  local entities = World.selectors.getByPosition(store.getState(), position)
  return not tables.any(entities, function(e) return e.door end)
end

return function(position, orientation)
  if not validateAction(position) then
    return nil
  end

  local a = Animator:new()
  a:addAnimation("opening", doors[orientation].opening)
  local entity = {
    sprite = doors[orientation].closed,
    position = position,
    door = true,
    closed = true,
    blocksMovement = true,
    blocksSight = true,
    orientation = orientation,
    animator = a
  }

  return addEntity(entity)
end