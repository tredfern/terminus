-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local map = {}

function map:constructor(props)
  self.width = props.width
  self.height = props.height
end


return class(map)