-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local outline = {}

function outline:constructor(width, height)
  self.width = width
  self.height = height
  self.rooms = {}
  self.corridors = {}
end

function outline:addRoom(room)
  self.rooms[#self.rooms + 1] = room
end

function outline:addCorridor(corridor)
  self.corridors[#self.corridors + 1] = corridor
end

return class(outline)