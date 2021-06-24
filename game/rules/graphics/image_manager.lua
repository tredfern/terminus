-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local class = require "moonpie.class"
local Colors = require "game.rules.graphics.colors"
local Wrapper = class({})
local ImageManager = {}
local store = {}
local imageData = {}


function Wrapper:constructor(imageKey)
  self.imageKey = imageKey
  self.color = Colors.drawDefault
end

function Wrapper:draw(sx, sy)
  -- This works around getting access back to the image manager on reloading
  local mgr = require "game.rules.graphics.image_manager"
  local i, q = mgr.get(self.imageKey)
  love.graphics.setColor(self.color)
  if q then
    love.graphics.draw(i, q, sx, sy)
  else
    love.graphics.draw(i, sx, sy)
  end
end

function Wrapper:setColor(c)
  self.color = c
end

function ImageManager.set(key, image, quad)
  store[key] = tables.pack(image, quad)
end

function ImageManager.get(key)
  if store[key] then
    return tables.unpack(store[key])
  end
end

function ImageManager.load(key, filename, quadData)
  local q = nil
  imageData[filename] = imageData[filename] or love.graphics.newImage(filename)
  if quadData then
    local x, y, w, h = tables.unpack(quadData)
    q = love.graphics.newQuad(x, y, w, h, imageData[filename])
  end

  ImageManager.set(key, imageData[filename], q)
  return ImageManager.getDrawable(key)
end

function ImageManager.getDrawable(key)
  return Wrapper:new(key)
end


return ImageManager