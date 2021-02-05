-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local terrain = require "game.rules.map.terrain"
local grid = require "moonpie.collections.grid"

local map = {}
map.defaultTerrain = terrain.blank

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


return class(map)