-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local imageMgr = require "moonpie.graphics.image"
local class = require "moonpie.class"
local sprite = class({})
local colors = require "game.graphics.colors"

function sprite:constructor(imageData)
  self.imageData = imageData
  self.color = colors.drawDefault
end


function sprite:currentImage()
  return self.imageData
end

function sprite.fromImage(imageData)
  return sprite:new(imageData)
end

function sprite.fromFile(imageFile)
  return sprite:new(imageMgr.load(imageFile))
end

function sprite:draw(sx, sy)
  love.graphics.setColor(self.color)
  love.graphics.draw(self.imageData, sx, sy)
end

return sprite