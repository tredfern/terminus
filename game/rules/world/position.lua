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
    x = x or 0,
    y = y or 0,
    z = z or 0
  }
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