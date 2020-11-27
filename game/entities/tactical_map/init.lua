-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local map = {}

function map:constructor(w, h)
  self.width = w
  self.height = h
end


return class(map)