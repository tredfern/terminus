-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local cargo = {}

function cargo:constructor(name, quantity)
  self.name = name
  self.quantity = quantity
end

return class(cargo)