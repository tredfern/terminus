-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Rooms = {}

local Descriptions = {
  "This room is smelly.",
  "There is a sticky goo covering the floor.",
  "It looks like there has been a major battle hear recently",
  "Everything is quiet... {color:danger}Too quiet.",
  "Hello?!? Hello!!?",
  "Dripping water echos off the walls.",
  "There is a faint smell of gasoline here.",
  "Do you smell toast?"
}

function Rooms.rectangular(x, y, width, height, level)
  return {
    x = x,
    y = y,
    width = width,
    height = height,
    level = level,
    features = {},
    description = tables.pickRandom(Descriptions)
  }
end


return Rooms