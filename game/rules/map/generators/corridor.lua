-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local Position = require "game.rules.world.position"

local function straightPath(startX, startY, endX, endY, level)
  local path = {}

  for x = math.min(startX, endX), math.max(startX, endX) do
    path[#path + 1] = Position(x, startY, level)
  end

  for y = math.min(startY, endY) + 1, math.max(startY, endY) do
    path[#path + 1] = Position(endX, y, level)
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
    path = straightPath(startX, startY, endX, endY, level)
  }
end


return createCorridor