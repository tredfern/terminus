-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local World = require "game.rules.world"
local ladders = require "assets.maps.features.ladders"

local Actions = {}

Actions.types = require "game.rules.map.types"


function Actions.addLadderDown(position)
  local ladder = {
    position = position,
    sprite = ladders.down,
    ladderDown = true
  }
  return World.actions.addEntity(ladder)
end

function Actions.addLadderUp(position)
  local ladder = {
    position = position,
    sprite = ladders.up,
    ladderUp = true
  }
  return World.actions.addEntity(ladder)
end

function Actions.add(outline, tileMap)
  return {
    type = Actions.types.ADD,
    payload = {
      outline = outline,
      tileMap = tileMap
    }
  }
end

function Actions.addCorridor(corridor)
  return {
    type = Actions.types.ADD_CORRIDOR,
    payload = {
      corridor = corridor
    }
  }
end

function Actions.addRoom(room)
  return {
    type = Actions.types.ADD_ROOM,
    payload = {
      room = room
    }
  }
end

function Actions.create(width, height, generator)
  return Thunk(
    Actions.types.CREATE,
    function(dispatch)
      local levels = 10
      local outline, tileMap = generator(width, height, levels)
      dispatch(Actions.add(outline, tileMap))
    end
  )
end

function Actions.setTileProperties(position, properties)
  return {
    type = Actions.types.SET_TILE_PROPERTIES,
    payload = {
      position = position,
      properties = properties
    }
  }
end

return Actions