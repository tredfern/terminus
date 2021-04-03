-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local imageMgr = require "moonpie.graphics.image"
local class = require "moonpie.class"
local sprite = class({})

function sprite:constructor(imageData)
  self.imageData = imageData
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

return sprite