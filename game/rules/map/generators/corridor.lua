-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function straightPath(startX, startY, endX, endY)
  local path = {}

  for x = math.min(startX, endX), math.max(startX, endX) do
    path[#path + 1] = { x = x, y = startY }
  end

  for y = math.min(startY, endY) + 1, math.max(startY, endY) do
    path[#path + 1] = { x = endX, y = y }
  end

  return path

end

local function createCorridor(startX, startY, endX, endY, level)
  return {
    startX = startX,
    startY = startY,
    endX = endX,
    endY = endY,
    level = level,
    path = straightPath(startX, startY, endX, endY)
  }
end


return createCorridor