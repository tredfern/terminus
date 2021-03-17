-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  north = function(x, y) return x, y - 1 end,
  east = function(x, y) return x + 1, y end,
  south = function(x, y) return x, y + 1 end,
  west = function(x, y) return x - 1, y end
}