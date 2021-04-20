-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")

local function is_position(_, args)
  local x, y, z = args[1] or 0, args[2] or 0, args[3] or 0
  return function(value)
    return value.x == x and value.y == y and value.z == z
  end
end

assert:register("matcher", "position", is_position)