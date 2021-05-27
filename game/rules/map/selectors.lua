-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.getDimensions(state)
  if not state or not state.map then
    return { width = 0, height = 0, levels = 0 }
  end

  return {
    width = state.map.width,
    height = state.map.height,
    levels = state.map.levels
  }
end

function Selectors.getRooms(state)
  return state.map.rooms
end


function Selectors.getTerrain(state, position)
  local terrain = require "game.rules.map.terrain"
  if state.map and state.map.tiles then
    local tile = state.map.tiles[position]
    if tile then return tile.terrain end
  end
  return terrain.list.blank
end

function Selectors.getTile(state, position)
  if state.map and state.map.tiles then
    return state.map.tiles[position]
  end
end

return Selectors