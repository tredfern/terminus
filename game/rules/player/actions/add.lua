-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"
local Animator = require "game.rules.graphics.animator"
local characterIdle = require "assets.characters.character_idle"

return function(position)
  local c = characters.create { position = position, isPlayerControlled = true }
  c.animator = Animator:new()
  c.animator:addAnimation("idle", characterIdle)
  c.animator:play("idle")
  return characters.actions.add(c)
end