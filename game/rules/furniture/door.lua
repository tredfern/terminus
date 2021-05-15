-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addEntity = require "game.rules.world.actions.add_entity"
local Animator = require "game.rules.graphics.animator"
local store = require "game.store"
local World = require "game.rules.world"
local tables = require "moonpie.tables"

local Door = {
  actions = {},
  selectors = {},
  images = require "assets.maps.features.doors"
}

local function validateAdd(position)
  local entities = World.selectors.getByPosition(store.getState(), position)
  return not tables.any(entities, function(e) return e.door end)
end

function Door.actions.add(position, orientation)
  if not validateAdd(position) then
    return nil
  end

  -- setup Animation
  local a = Animator:new()
  a:addAnimation("opening", Door.images[orientation].opening)

  local entity = {
    sprite = Door.images[orientation].closed,
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

return Door