-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.types"
local Position = require "game.rules.world.position"
local Terrain = require "game.rules.map.terrain"

local function ensureState(state)
  state.outline = state.outline or { rooms = {} }
  state.tileMap = state.tileMap or {}
end

local function roomTile(room)
  return {
    terrain = Terrain.list.room,
    room = room
  }
end

local function corridorTile()
  return {
    terrain = Terrain.list.corridor
  }
end

local reducer = {
  [types.ADD] = function(state, action)
    state.outline = action.payload.outline
    state.tileMap = action.payload.tileMap
    return state
  end,
  [types.ADD_ROOM] = function(state, action)
    ensureState(state)
    local room = action.payload.room
    table.insert(state.outline.rooms, room)

    for x=room.x, room.x + room.width do
      for y= room.y, room.y + room.height do
        state.tileMap[Position(x, y, room.level)] = roomTile(room)
      end
    end

    return state
  end,
  [types.ADD_CORRIDOR] = function(state, action)
    ensureState(state)
    local path = action.payload.corridor.path

    for _, pos in ipairs(path) do
      if state.tileMap[pos] == nil then
        state.tileMap[pos] = corridorTile(pos)
      end
    end

    return state
  end,
  [types.SET_DIMENSIONS] = function(state, action)
    state.width = action.payload.width
    state.height = action.payload.height
    state.levels = action.payload.levels
    return state
  end
}

return createSlice(reducer)