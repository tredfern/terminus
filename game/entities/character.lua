-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local character = {}

function character:constructor()
  self.x = 0
  self.y = 0
end

function character:set_position(x, y)
  self.x = x
  self.y = y
end

return class(character)