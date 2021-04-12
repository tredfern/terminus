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

function sprite.fromAtlas(imageData, x, y, width, height)
  local s = sprite:new(imageData)
  s:setQuad(x, y, width, height)
  return s
end

function sprite:draw(sx, sy)
  love.graphics.setColor(self.color)
  if self.quad then
    love.graphics.draw(self.imageData, self.quad, sx, sy)
  else
    love.graphics.draw(self.imageData, sx, sy)
  end
end

function sprite:setQuad(x, y, width, height)
  self.quad = love.graphics.newQuad(x, y, width, height, self.imageData)
end

return sprite