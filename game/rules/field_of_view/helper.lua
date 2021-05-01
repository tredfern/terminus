-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Map = require "game.rules.map"
local World = require "game.rules.world"
local tables = require "moonpie.tables"
local Helper = {}

function Helper.blocksSight(state, position)
  local terrain = Map.selectors.getTerrain(state, position)
  if terrain.blocksSight then return true end

  local entities = World.selectors.getByPosition(state, position)
  if tables.any(entities, function(e) return e.blocksSight end) then
    return true
  end

  return false
end


return Helper