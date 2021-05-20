-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.getDimensions(state)
  if not state or not state.map or not state.map.outline then
    return { width = 0, height = 0, levels = 0 }
  end

  return {
    width = state.map.outline.width,
    height = state.map.outline.height,
    levels = state.map.outline.levels
  }
end

function Selectors.getRooms(state)
  return state.map.outline.rooms
end


function Selectors.getTerrain(state, position)
  local terrain = require "game.rules.map.terrain"
  if state.map and state.map.tileMap then
    local tile = state.map.tileMap:getTile(position)
    if tile then return tile.terrain end
  end
  return terrain.list.blank
end

function Selectors.getTile(state, position)
  if state.map and state.map.tileMap then
    return state.map.tileMap:getTile(position)
  end
end

return Selectors