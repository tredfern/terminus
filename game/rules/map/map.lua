-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local terrain = require "game.rules.map.terrain"
local dungeon_generator = require "game.rules.map.generators.dungeon"
local grid = require "moonpie.collections.grid"

local map = {}

function map:constructor(props)
  props = props or {}
  self.width = props.width or 0
  self.height = props.height or 0
  self.data = grid:new(self.width, self.height)
  if self.width > 0 and self.height > 0 then
    dungeon_generator.generate(self)
  end
end

function map:get_index(x, y)
  return self.width * y + x
end

function map:get_terrain(x, y)
  return self.data:get(x, y) or terrain.blank
end

function map:set_terrain(x, y, v)
  self.data:set(x, y, v)
end


return class(map)