-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local vector = require "moonpie.math.vector"
local list = require "moonpie.collections.list"
local path = {}

function path.straight(x1, y1, x2, y2)
  local out = list:new()
  for x = math.min(x1, x2), math.max(x1, x2)  do
    out:add(vector.new(x, y1))
  end

  for y = math.min(y1, y2) + 1, math.max(y1, y2) do
    out:add(vector.new(x2, y))
  end

  return out
end


return path