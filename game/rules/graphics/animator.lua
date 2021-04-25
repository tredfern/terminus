-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local Animator = {}

function Animator:constructor()
  self.animations = {}
  self.playTime = 0
end

function Animator:addAnimation(name, animation)
  self.animations[name] = animation
end

function Animator:play(name, playOnce)
  self.current = self.animations[name]
  self.playTime = 0
  self.isLooping = not playOnce
end

function Animator:playOnce(name)
  self:play(name, true)
end

function Animator:update(delta)
  self.playTime = self.playTime + delta
end

function Animator:getCurrentFrame()
  if not self.isLooping then
    self.playTime = math.min(self.current.length, self.playTime)
  end
  return self.current:getFrameImage(self.playTime)
end

return class(Animator)