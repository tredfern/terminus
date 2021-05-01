-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local VisibilityMap = require "game.rules.field_of_view.visibility_map"
local Position = require "game.rules.world.position"
local Maths = require "moonpie.math"

local function createTestList(origin, radius)
  -- Set up list of points to test
  -- Do a parameter of rectangle based on radius. This is extra points but easier to calculate
  local testList = {}
  local top, bottom = origin.y - radius, origin.y + radius
  local left, right = origin.x - radius, origin.x + radius
  local z = origin.z

  for x = left, right do
    table.insert(testList, Position(x, top, z))
    table.insert(testList, Position(x, bottom, z))
  end

  for y = top, bottom do
    table.insert(testList, Position(left, y, z))
    table.insert(testList, Position(right, y, z))
  end

  return testList
end

local function getLineList(origin, destination)
  local pointList = {}
  local z = origin.z
  local x0,y0 = origin.x, origin.y
  local x1,y1 = destination.x, destination.y
  local sx, sy, dx, dy
  dx = math.abs(x1 - x0)
  sx = Maths.sign(x1 - x0)
  dy = math.abs(y1 - y0)
  sy = Maths.sign(y1 - y0)

  local err, e2 = dx-dy

  while not(x0 == x1 and y0 == y1) do
    e2 = err + err
    if e2 > -dy then
      err = err - dy
      x0  = x0 + sx
    end
    if e2 < dx then
      err = err + dx
      y0  = y0 + sy
    end
    table.insert(pointList, Position(x0, y0, z))
  end

  return pointList
end

local function isVisible()
  return true
end

return function(_, origin, radius)
  local vm = VisibilityMap:new()
  vm:setVisible(origin)

  local list = createTestList(origin, radius)

  -- iterate each one, retrieving whether from origin to test point it can be seen
  for _, testPoint in ipairs(list) do
    local lineList = getLineList(origin, testPoint)
    for _, v in ipairs(lineList) do
      if Position.distance(origin, v) > radius then
        break
      end

      if isVisible(v) then
        vm:setVisible(v)
      end
    end
  end

  return vm
end