-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Position = require "game.rules.world.position"
local Selectors = {}

function Selectors.blocksSight(state, position)
  local Map = require "game.rules.map"
  local World = require "game.rules.world"

  local terrain = Map.selectors.getTerrain(state, position)
  if terrain.blocksSight then return true end

  local entities = World.selectors.getByPosition(state, position)
  if tables.any(entities, function(e) return e.blocksSight end) then
    return true
  end

  return false
end

function Selectors.get(state, entity)
  if state.fieldOfView then
    return state.fieldOfView[entity]
  end
  return nil
end

function Selectors.getVisiblePositions(state, view)
  if state.fieldOfView then
    local vm = state.fieldOfView[view]
    local out = {}

    for k, v in pairs(vm) do
      -- TODO: This is required because of the OOP model of VisibilityMap #115
      if type(k) == "number" and v then
        table.insert(out, Position.fromKey(k))
      end
    end
    return out
  end
end

function Selectors.checkLineOfSight(state, from, to)
  for p in Position.line(from, to) do
    if Selectors.blocksSight(state, p) then
      return false
    end
  end

  return true
end

return Selectors