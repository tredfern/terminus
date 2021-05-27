-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local maths = require "moonpie.math"
local tables = require "moonpie.tables"
local terrain = require "game.rules.map.terrain"
local createCorridor = require "game.rules.map.generators.corridor"
local Rooms = require "game.rules.map.rooms"
local placeItems = require "game.rules.map.generators.place_items"
local Outline = require "game.rules.map.outline"
local TileMap = require "game.rules.map.tile_map"
local Walls = require "assets.graphics.walls"
local Position = require "game.rules.world.position"
local Orientation = require "game.rules.world.orientation"
local Actions = require "game.rules.map.actions"
local store = require "game.store"
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
        if maths.coinFlip() then
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

function generator.create_rooms(node, outline, level)
  if node.left or node.right then
    generator.create_rooms(node.left, outline, level)
    generator.create_rooms(node.right, outline, level)
    return
  end


  local width = love.math.random(math.ceil(node.width / 2), node.width - 1)
  local height = love.math.random(math.ceil(node.height / 2), node.height - 1)
  local x = node.x + love.math.random(node.width - width)
  local y = node.y + love.math.random(node.height - height)

  node.room = Rooms.rectangular(x, y, width, height, level)
  outline:addRoom(node.room)
  store.dispatch(Actions.addRoom(node.room))
end

function generator.generate(width, height, levels)
  local outline = Outline:new(width, height, levels)

  for level = 1, levels do
    local root = generator.create_node(1, 1, width, height)
    generator.divide(root, 1, DEPTH)
    generator.create_rooms(root, outline, level)
    generator.create_corridors(root, outline, level)

    -- Connect to lower floor
    generator.connectLevels(outline, level, level - 1)
  end
  local tileMap = generator.buildTileMap(outline)
  placeItems(outline, tileMap)
  return outline, tileMap
end


function generator.create_corridors(node, outline, level)
  if node.left or node.right then
    generator.create_corridors(node.left, outline, level)
    generator.create_corridors(node.right, outline, level)
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

    local corridor = createCorridor(start_x, start_y, end_x, end_y, level)
    outline:addCorridor(corridor)
    store.dispatch(Actions.addCorridor(corridor))
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
  generator.addFeatures(outline, map)

  return map
end

function generator.buildCorridor(map, corridor)
  for _, square in ipairs(corridor.path) do
    local p = Position(square.x, square.y, corridor.level)
    local tile = map:getTile(p)
    if tile == nil or tile.terrain == nil then
      map:updateTile(p, { terrain = terrain.list.corridor })
    end
  end
end

function generator.fillWalls(map)
  for x = 1, map.width do
    for y = 1, map.height do
      for z = 1, map.levels do
        local pos = Position(x, y, z)
        if map:getTile(pos) == nil then
          local neighbors = map:getNeighbors(pos)
          local list = tables.keysToList(neighbors)
          if tables.any(list, function(tile) return tile.position.z == z and not tile.isWall end) then
            map:updateTile(pos, { terrain = terrain.list.wall, isWall = true })
            store.dispatch(Actions.setTileProperties(pos, { terrain = terrain.list.wall, isWall = true }))
          end
        end
      end
    end
  end
end

function generator.buildRoom(map, room)
  for x = 0, room.width - 1 do
    for y = 0, room.height - 1 do
      map:updateTile(Position(room.x + x, room.y + y, room.level), { terrain = terrain.list.room, room = room })
    end
  end
end

function generator.calculateSprites(map)
  local sprite = require "game.rules.graphics.sprite"
  for x = 1, map.width do
    for y=1,map.height do
      for z = 1,map.levels do
        local tile = map:getTile(Position(x, y, z))
        local neighbors = map:getNeighbors(Position(x, y, z))

        if tile and tile.terrain then
          if tile.terrain.images then
            local tileImage = sprite.fromImage(tables.pickRandom(tile.terrain.images))
            tileImage.color = tile.terrain.color
            store.dispatch(Actions.setTileProperties(Position(x, y, z), { sprite = tileImage }))
          end
          if tile.isWall then
            local sequence = { "n", "s", "e", "w" }
            local index = ""

            for _, v in ipairs(sequence) do
              if neighbors[v] and neighbors[v].isWall then
                index = index .. v
              end
            end

            store.dispatch(Actions.setTileProperties(Position(x, y, z), { sprite = Walls[index] }))
          end
        end
      end
    end
  end
end

function generator.getRandomLocation(outline)
  local r = tables.pickRandom(outline.rooms)
  local x = math.random(r.x, r.x + r.width)
  local y = math.random(r.y, r.y + r.height)
  return x, y, r.level
end

function generator.addFeatures(outline, map)
  for _, r in ipairs(outline.rooms) do
    if not tables.isEmpty(r.features) then
      for _, f in ipairs(r.features) do
        if f.type == "LADDER_UP" then
          store.dispatch(Actions.addLadderUp(f.position))
        elseif f.type == "LADDER_DOWN" then
          store.dispatch(Actions.addLadderDown(f.position))
        end
      end
    end

    -- search parameter to find where corridor joins room and add a door

    for x = r.x, r.x + r.width do
      local top, bottom = r.y - 1, r.y + r.height
      local t = map:getTile(Position(x, top, r.level))
      local b = map:getTile(Position(x, bottom, r.level))

      generator.addDoorMaybe(t, Orientation.northSouth, map:getNeighbors(Position(x, top, r.level)))
      generator.addDoorMaybe(b, Orientation.northSouth, map:getNeighbors(Position(x, bottom, r.level)))
    end

    for y = r.y, r.y + r.height do
      local left, right = r.x - 1, r.x + r.width

      local ld = map:getTile(Position(left, y, r.level))
      local rd = map:getTile(Position(right, y, r.level))

      generator.addDoorMaybe(ld, Orientation.eastWest, map:getNeighbors(Position(left, y, r.level)))
      generator.addDoorMaybe(rd, Orientation.eastWest, map:getNeighbors(Position(right, y, r.level)))
    end

  end
end

function generator.addDoorMaybe(tile, orientation, neighbors)
  local Door = require "game.rules.map.furniture.door"

  local asWalls = function(n1, n2)
    return n1 and n2 and n1.terrain == terrain.list.wall and n2.terrain == terrain.list.wall
  end

  if tile and tile.terrain == terrain.list.corridor then
    if orientation == Orientation.eastWest then
      if asWalls(neighbors.n, neighbors.s) then
        store.dispatch(Door.actions.add(tile.position, orientation))
      end
    elseif orientation == Orientation.northSouth then
      if asWalls(neighbors.e, neighbors.w) then
        store.dispatch(Door.actions.add(tile.position, orientation))
      end
    end

    -- potentially lock a door
    if math.random(100) > 85 then
      local d = Door.selectors.getByPosition(store.getState(), tile.position)
      if d then
        store.dispatch(Door.actions.lock(d))
      end
    end
  end
end

function generator.connectLevels(outline, start, dest)
  local roomsOnSourceLevel = tables.select(outline.rooms, function(r) return r.level == start end)
  local roomsOnDestLevel = tables.select(outline.rooms, function(r) return r.level == dest end)

  -- find an overlapping room
  local startRoom, destRoom, startRect
  while #roomsOnSourceLevel > 0 and destRoom == nil do
    startRoom = tables.pickRandom(roomsOnSourceLevel)
    startRect = maths.rectangle.new(startRoom.x, startRoom.y, startRoom.width, startRoom.height)
    local overlap = tables.select(roomsOnDestLevel, function(r)
      local destRect = maths.rectangle.new(r.x, r.y, r.width, r.height)
      return startRect:intersects(destRect)
    end)
    if not tables.isEmpty(overlap) then
      destRoom = overlap[1]
    end
    tables.removeItem(roomsOnSourceLevel, start)
  end

  if destRoom == nil or startRoom == nil then return end

  local destRect = maths.rectangle.new(destRoom.x, destRoom.y, destRoom.width, destRoom.height)
  local overlap = startRect:overlap(destRect)

  local x = math.random(overlap:left(), overlap:right() - 1)
  local y = math.random(overlap:top(), overlap:bottom() - 1)

  -- add ladders to feature list
  -- These should be fully scoped out entities that can be added later
  table.insert(destRoom.features, { type = "LADDER_UP", position = Position(x, y, destRoom.level) })
  table.insert(startRoom.features, { type = "LADDER_DOWN", position = Position(x, y, startRoom.level) })
end

return setmetatable(generator,
  {
    __call = function(self, width, height, levels)
      return self.generate(width, height, levels)
    end
  })