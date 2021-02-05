-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local terrain = require "game.rules.map.terrain"
local path = require "game.rules.map.generators.path"
local math_ext = require "moonpie.math"
local generator = {}

local MIN_SIZE_TO_DIVIDE = 8
local DEPTH = 4

function generator.create_node(x, y, width, height)
  return {
    x = x,
    y = y,
    width = width,
    height = height,
    pick_room = function(self)
      if self.room then return self.room end

      if self.left and self.right then
        if math_ext.coinFlip() then
          return self.left:pick_room()
        else
          return self.right:pick_room()
        end
      end
    end
  }
end

function generator.divide_on_x(node)
  local border = math.floor(node.width / 4)
  local p = math.random(border, node.width - border)

  node.left = generator.create_node(node.x, node.y, p, node.height)
  node.right = generator.create_node(node.x + p, node.y, node.width - p, node.height)
end

function generator.divide_on_y(node)
  local border = math.floor(node.height / 4)
  local p = math.random(border, node.height - border)

  node.left = generator.create_node(node.x, node.y, node.width, p)
  node.right = generator.create_node(node.x, node.y + p, node.width, node.height - p)
end

function generator.divide(node, current_level, max_levels)
  if current_level > max_levels then return end
  if node.width < MIN_SIZE_TO_DIVIDE and node.height < MIN_SIZE_TO_DIVIDE then return end

  if node.width >= node.height then
    generator.divide_on_x(node)
  else
    generator.divide_on_y(node)
  end

  generator.divide(node.left, current_level + 1, max_levels)
  generator.divide(node.right, current_level + 1, max_levels)

  return node
end

function generator.create_rooms(node)
  if node.left or node.right then
    generator.create_rooms(node.left)
    generator.create_rooms(node.right)
    return
  end


  local width = math.random(math.ceil(node.width / 2), node.width - 1)
  local height = math.random(math.ceil(node.height / 2), node.height - 1)
  local x = node.x + math.random(node.width - width)
  local y = node.y + math.random(node.height - height)

  node.room = {
    x = x, y = y, width = width, height = height
  }
end

function generator.generate(width, height)
  local mapHelper = require "game.rules.map.helper"
  local new_map = mapHelper:new { width = width, height = height }

  local root = generator.create_node(1, 1, new_map.width, new_map.height)
  generator.divide(root, 1, DEPTH)
  generator.create_rooms(root)

  -- generator.add_border_walls(map, root)
  generator.add_rooms(new_map, root)
  generator.add_corridors(new_map, root)

  return new_map
end

function generator.add_border_walls(map, node)
  if node.left or node.right then
    generator.add_border_walls(map, node.left)
    generator.add_border_walls(map, node.right)
  else
    for x = 0, node.width - 1 do
      map:setTerrain(node.x + x, node.y, terrain.boundary)
      map:setTerrain(node.x + x, node.y + node.height, terrain.boundary)
    end

    for y = 0, node.height - 1 do
      map:setTerrain(node.x, node.y + y, terrain.boundary)
      map:setTerrain(node.x + node.width, node.y + y, terrain.boundary)
    end
  end
end

function generator.add_rooms(map, node)
  if node.left or node.right then
    generator.add_rooms(map, node.left)
    generator.add_rooms(map, node.right)
    return
  end


  map.rooms[#map.rooms + 1] = node.room

  for x = 0, node.room.width - 1 do
    for y = 0, node.room.height - 1 do
      map:setTerrain(node.room.x + x, node.room.y + y, terrain.room)
    end
  end
end

function generator.add_corridors(map, node)
  if node.left or node.right then
    generator.add_corridors(map, node.left)
    generator.add_corridors(map, node.right)
  end

  --Connect the left and right nodes together...
  if node.left and node.right then
    local start_room = node.left:pick_room()
    local end_room = node.right:pick_room()
    -- pick 2 connecting points
    local start_x = math.random(start_room.x, start_room.x + start_room.width - 1)
    local start_y = math.random(start_room.y, start_room.y + start_room.height - 1)

    local end_x = math.random(end_room.x, end_room.x + end_room.width - 1)
    local end_y = math.random(end_room.y, end_room.y + end_room.height - 1)

    generator.build_corridor(map, start_x, start_y, end_x, end_y)
  end
end

function generator.build_corridor(map, start_x, start_y, end_x, end_y)
  local p = path.straight(start_x, start_y, end_x, end_y)

  for _, v in ipairs(p) do
    if map:getTerrain(v.x, v.y) == terrain.blank then
      map:setTerrain(v.x, v.y, terrain.corridor)
    end
  end
end

return generator