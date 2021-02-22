-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local terrain = require "game.rules.map.terrain"
local grid = require "moonpie.collections.grid"

local map = {}
map.defaultTerrain = terrain.list.blank

function map:constructor(props)
  props = props or {}
  self.width = props.width or 0
  self.height = props.height or 0
  self.data = grid:new(self.width, self.height)
  self.rooms = {}
end

function map:getTerrain(x, y)
  return self.data:get(x, y) or self.defaultTerrain
end

function map:setTerrain(x, y, v)
  self.data:set(x, y, v)
end


function map:getNeighbors(x, y)
  return {
    nw = self:getTerrain(x - 1, y - 1),
    n = self:getTerrain(x, y - 1),
    ne = self:getTerrain(x + 1, y - 1),
    w = self:getTerrain(x - 1, y),
    e = self:getTerrain(x + 1, y),
    sw = self:getTerrain(x - 1, y + 1),
    s = self:getTerrain(x, y + 1),
    se = self:getTerrain(x + 1, y + 1)
  }
end

return class(map)