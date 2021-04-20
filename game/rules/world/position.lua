-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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

local function new(x, y, z)
  return {
    x = x,
    y = y,
    z = z
  }
end

local function northwest(position)
  return new(position.x - 1, position.y - 1, position.z)
end

local function north(position)
  return new(position.x, position.y - 1, position.z)
end

local function northeast(position)
  return new(position.x + 1, position.y - 1, position.z)
end

local function west(position)
  return new(position.x - 1, position.y, position.z)
end

local function east(position)
  return new(position.x + 1, position.y, position.z)
end

local function southwest(position)
  return new(position.x - 1, position.y + 1, position.z)
end

local function south(position)
  return new(position.x, position.y + 1, position.z)
end

local function southeast(position)
  return new(position.x + 1, position.y + 1, position.z)
end

local function up(position)
  return new(position.x, position.y, position.z + 1)
end

local function down(position)
  return new(position.x, position.y, position.z - 1)
end

return setmetatable({
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