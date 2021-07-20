-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local maths = require "moonpie.math"
local tables = require "moonpie.tables"
local readOnly = require "moonpie.utility.read_only_table"
local Position = {}
local hashDB = {}
local cache = {}


function Position.createHashKey(x, y, z)
  -- Credit for algorithm: https://dmauro.com/post/77011214305/a-hashing-function-for-x-y-z-coordinates
  x, y, z = x or 0, y or 0, z or 0
  if x >= 0 then x = 2 * x else x = -2 * x - 1 end
  if y >= 0 then y = 2 * y else y = -2 * y - 1 end
  if z >= 0 then z = 2 * z else z = -2 * z - 1 end

  local m = math.max(x, y, z)
  local hash = math.pow(m, 3) + (2 * m * z) + z
  if m == z then
    hash = hash + math.pow(math.max(x, y), 2)
  end

  if y >= x then
    hash = hash + x + y
  else
    hash = hash + y
  end
  return hash
end

function Position.equal(start, dest)
  if dest.x then
    return start.x == dest.x and
      start.y == dest.y and
      start.z == dest.z
  else
    return start.x == dest[1] and
      start.y == dest[2] and
      start.z == dest[3]
  end
end

function Position.distance(start, dest)
  return math.sqrt(
    math.pow(dest.x - start.x, 2) +
    math.pow(dest.y - start.y, 2) +
    math.pow(dest.z - start.z, 2)
  )
end

function Position.checkCache(x, y, z)
  if cache[x] and cache[x][y] and cache[x][y][z] then
    return cache[x][y][z]
  end
end

function Position.cache(position)
  local x, y, z = position.x, position.y, position.z
  if not cache[x] then cache[x] = {} end
  if not cache[x][y] then cache[x][y] = {} end
  if not cache[x][y][z] then cache[x][y][z] = position end
end

function Position.new(x, y, z)
  local p = Position.checkCache(x, y, z)
  if p then return p end
  p = readOnly {
    x = x or 0,
    y = y or 0,
    z = z or 0,
    hashKey = Position.createHashKey(x, y, z)
  }

  -- Add in a nice to string implementation
  local mt = getmetatable(p)
  mt.__tostring = function(self)
    return string.format("Pos(%d, %d, %d)", self.x, self.y, self.z)
  end
  Position.cache(p)
  hashDB[p.hashKey] = p

  return p
end

function Position.add(position, delta)
  local x = delta[1] or 0
  local y = delta[2] or 0
  local z = delta[3] or 0

  return Position.new(
    position.x + x,
    position.y + y,
    position.z + z
  )
end

function Position.fromKey(key)
  return hashDB[key]
end

function Position.northwest(position)
  return Position.add(position, { -1, -1, 0 })
end

function Position.north(position)
  return Position.add(position, { 0, -1, 0 })
end

function Position.northeast(position)
  return Position.add(position, { 1, -1, 0 })
end

function Position.west(position)
  return Position.add(position, { -1, 0, 0 })
end

function Position.east(position)
  return Position.add(position, { 1, 0, 0 })
end

function Position.southwest(position)
  return Position.add(position, { -1, 1, 0 })
end

function Position.south(position)
  return Position.add(position, { 0, 1, 0 })
end

function Position.southeast(position)
  return Position.add(position, { 1, 1, 0 })
end

function Position.up(position)
  return Position.add(position, { 0, 0, 1 })
end

function Position.down(position)
  return Position.add(position, { 0, 0, -1 })
end

function Position.randomInRoom(room)
  return Position(
    math.random(room.x, room.x + room.width - 1),
    math.random(room.y, room.y + room.height - 1),
    room.level
  )
end

function Position.box(from, to)
  local stepX = maths.sign(to.x - from.x)
  local stepY = maths.sign(to.y - from.y)
  local stepZ = maths.sign(to.z - from.z)
  local next = from

  return function()
    if next == nil then return nil end
    local out = next

    if next.x ~= to.x then
      next = Position(next.x + stepX, next.y, next.z)
    elseif next.y ~= to.y then
      next = Position(from.x, next.y + stepY, next.z)
    elseif next.z ~= to.z then
      next = Position(from.x, from.y, next.z + stepZ)
    else
      next = nil
    end

    return out
  end
end

function Position.createUniqueList(from, to, count)
  local allPoints = {}
  for p in Position.box(from, to) do
    table.insert(allPoints, p)
  end

  local outList = {}

  for _ = 1, count do
    table.insert(outList, tables.popRandom(allPoints))
  end

  return outList
end

function Position.line(from, to)
  assert(from.z == to.z)
  local z = from.z
  local x0,y0 = from.x, from.y
  local x1,y1 = to.x, to.y
  local sx, sy, dx, dy
  dx = math.abs(x1 - x0) -- Distance for X
  sx = maths.sign(x1 - x0) -- Direction for X
  dy = math.abs(y1 - y0) -- Distance for Y
  sy = maths.sign(y1 - y0) -- Direction for Y

  local err, e2 = dx-dy -- Tracking the offset/err we have incurred
  local first = true

  return function()
    -- don't run the calculations the first step, just return the starting position
    if first then
      first = nil
      return from
    end

    if x0 == x1 and y0 == y1 then return nil end

    e2 = err + err
    if e2 > -dy then
      err = err - dy
      x0  = x0 + sx
    end
    if e2 < dx then
      err = err + dx
      y0  = y0 + sy
    end

    return Position(x0, y0, z)
  end
end

return setmetatable(Position, {
  __call = function(self, x, y, z)
    return self.new(x, y, z)
  end,
  __tostring = function(self)
    return string.format("Pos(%d, %d, %d)", self.x, self.y, self.z)
  end
})