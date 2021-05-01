-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local VisibilityMap = {}

function VisibilityMap:setVisible(position)
  self[position.hashKey] = true
end

function VisibilityMap:isVisible(position)
  return self[position.hashKey] == true
end


return class(VisibilityMap)