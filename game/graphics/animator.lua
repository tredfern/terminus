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

function Animator:play(name)
  self.current = self.animations[name]
  self.playTime = 0
end

function Animator:update(delta)
  self.playTime = self.playTime + delta
end

function Animator:getCurrentFrame()
  return self.current:getFrameImage(self.playTime)
end

return class(Animator)