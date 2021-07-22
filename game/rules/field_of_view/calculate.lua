-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Position = require "game.rules.world.position"
local VisibilityMap = require "game.rules.field_of_view.visibility_map"
local Selectors = require "game.rules.field_of_view.selectors"

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

return function(state, origin, radius)
  local vm = VisibilityMap:new()
  vm:setVisible(origin)

  local list = createTestList(origin, radius)

  -- iterate each one, retrieving whether from origin to test point it can be seen
  for _, testPoint in ipairs(list) do
    for testPos in Position.line(origin, testPoint) do
      if Position.distance(origin, testPos) > radius then
        break
      end

      vm:setVisible(testPos)
      if Selectors.blocksSight(state, testPos) then
        break
      end
    end
  end

  return vm
end