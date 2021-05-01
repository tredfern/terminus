-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function createHashKey(x, y, z)
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

local function compare(start, dest)
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

local function distance(start, dest)
  return math.sqrt(
    math.pow(dest.x - start.x, 2) +
    math.pow(dest.y - start.y, 2) +
    math.pow(dest.z - start.z, 2)
  )
end

local function new(x, y, z)
  return {
    x = x or 0,
    y = y or 0,
    z = z or 0,
    hashKey = createHashKey(x, y, z)
  }
end

local function copy(position)
  return new(
    position.x,
    position.y,
    position.z
  )
end

local function add(position, delta)
  local x = delta[1] or 0
  local y = delta[2] or 0
  local z = delta[3] or 0

  return new(
    position.x + x,
    position.y + y,
    position.z + z
  )
end

local function northwest(position)
  return add(position, { -1, -1, 0 })
end

local function north(position)
  return add(position, { 0, -1, 0 })
end

local function northeast(position)
  return add(position, { 1, -1, 0 })
end

local function west(position)
  return add(position, { -1, 0, 0 })
end

local function east(position)
  return add(position, { 1, 0, 0 })
end

local function southwest(position)
  return add(position, { -1, 1, 0 })
end

local function south(position)
  return add(position, { 0, 1, 0 })
end

local function southeast(position)
  return add(position, { 1, 1, 0 })
end

local function up(position)
  return add(position, { 0, 0, 1 })
end

local function down(position)
  return add(position, { 0, 0, -1 })
end

return setmetatable({
  add = add,
  copy = copy,
  distance = distance,
  new = new,
  equal = compare,
  northwest = northwest,
  north = north,
  northeast = northeast,
  west = west,
  east = east,
  southwest = southwest,
  south = south,
  southeast = southeast,
  up = up,
  down = down
}, {
  __call = function(_, x, y, z)
    return new(x, y, z)
  end
})