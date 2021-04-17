-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local tables = require "moonpie.tables"

local Animation = {}

function Animation:constructor()
  self.frames = {}
end

function Animation:addFrame(image, length)
  self.frames[#self.frames + 1] = {
    image = image,
    length = length
  }
  self.length = tables.sum(self.frames, function(f) return f.length end)
end

function Animation:getFrame(delta)
  local offset = delta % self.length

  for _, v in ipairs(self.frames) do
    offset = offset - v.length
    if offset <=0 then
      return v
    end
  end
end

function Animation:getFrameImage(delta)
  return self:getFrame(delta).image
end

return class(Animation)