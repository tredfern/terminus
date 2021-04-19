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

return {
  new = new,
  equal = compare
}