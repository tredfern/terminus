-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local modifiers = { -3, -2, -2, -1, -1, -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3}
local attribute = {}

function attribute:constructor(value)
  self.score = value
end

function attribute:modifier()
  if not self.score then return nil end

  if self.score + 1 > #modifiers then
    return modifiers[#modifiers]
  end

  return modifiers[self.score + 1]
end


return class(attribute)