-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local color = require "game.graphics.colors"
local imageMgr = require "moonpie.graphics.image"
local walls = imageMgr.load("assets/graphics/placeholder-walls.png")

local wallSprite = { }
wallSprite.se = love.graphics.newQuad(0, 0, 32, 32, walls)
wallSprite.nsew = love.graphics.newQuad(32, 0, 32, 32, walls)
wallSprite.ew = love.graphics.newQuad(64, 0, 32, 32, walls)
wallSprite.sw = love.graphics.newQuad(96, 0, 32, 32, walls)
wallSprite.nse = love.graphics.newQuad(0, 32, 32, 32, walls)
wallSprite.w = love.graphics.newQuad(32, 32, 32, 32, walls)
wallSprite.e = love.graphics.newQuad(64, 32, 32, 32, walls)
wallSprite.nsw = love.graphics.newQuad(96, 32, 32, 32, walls)
wallSprite.ns = love.graphics.newQuad(0, 64, 32, 32, walls)
wallSprite.s = love.graphics.newQuad(32, 64, 32, 32, walls)
wallSprite.sew = love.graphics.newQuad(32, 64, 32, 32, walls)
wallSprite.ne = love.graphics.newQuad(0, 96, 32, 32, walls)
wallSprite.new = love.graphics.newQuad(32, 96, 32, 32, walls)
wallSprite.n = love.graphics.newQuad(64, 96, 32, 32, walls)
wallSprite.nw = love.graphics.newQuad(96, 96, 32, 32, walls)

function wallSprite:draw(sx, sy, _)
  love.graphics.setColor(color.drawDefault)
  love.graphics.draw(walls, wallSprite.ew, sx, sy)
end

return wallSprite