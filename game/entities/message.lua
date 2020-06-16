-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local message = {}

function message:constructor(msg)
  self.message = msg
end

return class(message)