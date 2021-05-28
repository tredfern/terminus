-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.types"
local Position = require "game.rules.world.position"
local Terrain = require "game.rules.map.terrain"
local tables = require "moonpie.tables"

local function ensureState(state)
  state.rooms = state.rooms or { }
  state.tiles = state.tiles or { }
end

local function setTileProps(state, pos, props)
  local t = state.tiles[pos] or { position = pos }
  tables.copyKeys(props, t, true)
  state.tiles[pos] = t
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
    table.insert(state.rooms, room)

    for x=room.x, room.x + room.width do
      for y= room.y, room.y + room.height do
        local pos = Position(x, y, room.level)
        setTileProps(state, pos, { terrain = Terrain.list.room, room = room })
      end
    end

    return state
  end,
  [types.ADD_CORRIDOR] = function(state, action)
    ensureState(state)
    local path = action.payload.corridor.path

    for _, pos in ipairs(path) do
      if state.tiles[pos] == nil then
        setTileProps(state, pos, { terrain = Terrain.list.corridor })
      end
    end

    return state
  end,
  [types.SET_DIMENSIONS] = function(state, action)
    state.width = action.payload.width
    state.height = action.payload.height
    state.levels = action.payload.levels
    return state
  end,
  [types.SET_TILE_PROPERTIES] = function(state, action)
    ensureState(state)
    local pos, props = action.payload.position, action.payload.properties
    setTileProps(state, pos, props)
    return state
  end
}

return createSlice(reducer)