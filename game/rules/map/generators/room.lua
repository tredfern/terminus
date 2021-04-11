-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function createRoom(x, y, width, height)
  return {
    x = x,
    y = y,
    width = width,
    height = height
  }
end


return createRoom