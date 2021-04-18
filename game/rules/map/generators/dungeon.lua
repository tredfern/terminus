-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local math_ext = require "moonpie.math"
local tables = require "moonpie.tables"
local terrain = require "game.rules.map.terrain"
local createCorridor = require "game.rules.map.generators.corridor"
local createRoom = require "game.rules.map.generators.room"
local Outline = require "game.rules.map.outline"
local TileMap = require "game.rules.map.tile_map"
local Walls = require "assets.graphics.walls"
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
  local p = love.math.random(border, node.width - border)

  node.left = generator.create_node(node.x, node.y, p, node.height)
  node.right = generator.create_node(node.x + p, node.y, node.width - p, node.height)
end

function generator.divide_on_y(node)
  local border = math.floor(node.height / 4)
  local p = love.math.random(border, node.height - border)

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

function generator.create_rooms(node, outline)
  if node.left or node.right then
    generator.create_rooms(node.left, outline)
    generator.create_rooms(node.right, outline)
    return
  end


  local width = love.math.random(math.ceil(node.width / 2), node.width - 1)
  local height = love.math.random(math.ceil(node.height / 2), node.height - 1)
  local x = node.x + love.math.random(node.width - width)
  local y = node.y + love.math.random(node.height - height)

  node.room = createRoom(x, y, width, height)
  outline:addRoom(node.room)
end

function generator.generate(width, height)
  local outline = Outline:new(width, height)
  local root = generator.create_node(1, 1, width, height)
  generator.divide(root, 1, DEPTH)
  generator.create_rooms(root, outline)
  generator.create_corridors(root, outline)
  local tileMap = generator.buildTileMap(outline)
  return outline, tileMap
end


function generator.create_corridors(node, outline)
  if node.left or node.right then
    generator.create_corridors(node.left, outline)
    generator.create_corridors(node.right, outline)
  end

  --Connect the left and right nodes together...
  if node.left and node.right then
    local start_room = node.left:pick_room()
    local end_room = node.right:pick_room()
    -- pick 2 connecting points
    local start_x = love.math.random(start_room.x, start_room.x + start_room.width - 1)
    local start_y = love.math.random(start_room.y, start_room.y + start_room.height - 1)

    local end_x = love.math.random(end_room.x, end_room.x + end_room.width - 1)
    local end_y = love.math.random(end_room.y, end_room.y + end_room.height - 1)

    outline:addCorridor(createCorridor(start_x, start_y, end_x, end_y))
  end
end

---
-- Moving soon
---

function generator.buildTileMap(outline)
  local map = TileMap:new()

  for _, room in ipairs(outline.rooms) do
    generator.buildRoom(map, room)
  end

  for _, corridor in ipairs(outline.corridors) do
    generator.buildCorridor(map, corridor)
  end

  generator.fillWalls(map)
  generator.calculateSprites(map)
  generator.addFeatures(outline)

  return map
end

function generator.buildCorridor(map, corridor)
  for _, square in ipairs(corridor.path) do
    local tile = map:getTile(square.x, square.y)
    if tile == nil or tile.terrain == nil then
      map:updateTile(square.x, square.y, { terrain = terrain.list.corridor })
    end
  end
end

function generator.fillWalls(map)
  for x = 1, map.width do
    for y = 1, map.height do
      if map:getTile(x, y) == nil then
        local neighbors = map:getNeighbors(x, y)
        local list = tables.keysToList(neighbors)
        if tables.any(list, function(tile) return not tile.isWall end) then
          map:updateTile(x, y, { terrain = terrain.list.wall, isWall = true })
        end
      end
    end
  end
end

function generator.buildRoom(map, room)
  for x = 0, room.width - 1 do
    for y = 0, room.height - 1 do
      map:updateTile(room.x + x, room.y + y, { terrain = terrain.list.room })
    end
  end
end

function generator.calculateSprites(map)
  local sprite = require "game.rules.graphics.sprite"
  for x = 1, map.width do
    for y=1,map.height do
      local tile = map:getTile(x, y)
      local neighbors = map:getNeighbors(x, y)

      if tile and tile.terrain then
        if tile.terrain.images then
          local tileImage = sprite.fromImage(tables.pickRandom(tile.terrain.images))
          tileImage.color = tile.terrain.color
          map:updateTile(x, y, { sprite = tileImage })
        end
        if tile.isWall then
          local sequence = { "n", "s", "e", "w" }
          local index = ""

          for _, v in ipairs(sequence) do
            if neighbors[v] and neighbors[v].isWall then
              index = index .. v
            end
          end

          map:updateTile(x, y, { sprite = Walls[index] })
        end
      end
    end
  end
end

function generator.getRandomLocation(outline)
  local r = tables.pickRandom(outline.rooms)
  local x = math.random(r.x, r.x + r.width)
  local y = math.random(r.y, r.y + r.height)
  return x, y
end

function generator.addFeatures(outline)
  for _ = 1, 3 do
    local store = require "game.store"
    local addLadder = require "game.rules.map.actions.add_ladder"
    local x, y = generator.getRandomLocation(outline)
    store.dispatch(addLadder(x, y))
  end
end

return setmetatable(generator,
  {
    __call = function(self, width, height)
      return self.generate(width, height)
    end
  })