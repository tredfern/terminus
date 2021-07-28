-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local tables = require "moonpie.tables"
local World = require "game.rules.world"
local Position = require "game.rules.world.position"
local Rooms = require "game.rules.map.rooms"
local ladders = require "assets.maps.features.ladders"
local maths = require "moonpie.math"

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
      dispatch(Actions.setDimensions(width, height, levels))

      generator(width, height, levels)

      dispatch(Actions.populate())
    end
  )
end

function Actions.populate()
  -- Add some prickly bushes to 10 rooms on the map
  local Bestiary = require "game.rules.bestiary"
  local Characters = require "game.rules.character"
  local Spiders = require "assets.bestiary.spiders"

  return Thunk(
    Actions.types.POPULATE,
    function(dispatch, getState)
      local Selectors = require "game.rules.map.selectors"
      local rooms = Selectors.getRooms(getState())

      if rooms then
        -- PRICKLY BUSHES
        for _ = 1, 10 do
          local room = tables.pickRandom(rooms)
          -- Fill about 1/3 of the room
          local count = Rooms.getArea(room) / 3
          -- Create a unique list of positions in an area
          local positionList = Position.createUniqueList(
            Position(room.x, room.y, room.level),
            Position(room.x + room.width, room.y + room.height, room.level),
            count)

          for _, pos in ipairs(positionList) do
            dispatch(Bestiary.actions.add(Bestiary.plants.prickleBush(), pos))
          end
        end


        for _ = 1, #rooms / 2 do
          local room = tables.pickRandom(rooms)

          -- add a 2-5 spiders
          local count = maths.prandom(2, 5)
          for _ = 1, count do
            local p = Position.randomInRoom(room)
            dispatch(Characters.actions.new(Spiders.crawler, p))
          end
        end
      end
    end
  )
end

function Actions.setDimensions(width, height, levels)
  return {
    type = Actions.types.SET_DIMENSIONS,
    payload = {
      width = width, height = height, levels = levels
    }
  }
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