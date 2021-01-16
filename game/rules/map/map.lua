-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local terrain = require "game.rules.map.terrain"
local tables = require "moonpie.tables"

local map = {}

function map:constructor(props)
  props = props or {}
  self.width = props.width or 0
  self.height = props.height or 0
  self:random_fill()
end

function map:random_fill()
  local terrains = {
    terrain.dirt, terrain.grass, terrain.water
  }
  for x = 1, self.width do
    for y = 1, self.height do
      self[self:get_index(x,y)] = tables.pick_random(terrains)
    end
  end
end

function map:get_index(x, y)
  return self.width * y + x
end

function map:get_terrain(x, y)
  return self[self:get_index(x, y)]
end


return class(map)