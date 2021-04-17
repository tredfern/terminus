-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"
local Animator = require "game.rules.graphics.animator"
local characterIdle = require "data.characters.character_idle"

return function(x, y)
  local c = characters.create { x = x, y = y, isPlayerControlled = true }
  c.animator = Animator:new()
  c.animator:addAnimation("idle", characterIdle)
  c.animator:play("idle")
  return characters.actions.add(c)
end