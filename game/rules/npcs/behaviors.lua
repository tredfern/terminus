-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Behaviors = {}

function Behaviors.moveTowardsPlayer(npc, dispatch, getState)
  local Position = require "game.rules.world.position"
  local player = require "game.rules.player"
  local character = require "game.rules.character"
  local pc = player.selectors.getPlayer(getState())

  local x = 0
  if npc.position.x < pc.position.x then x = 1 end
  if npc.position.x > pc.position.x then x = -1 end

  local y = 0
  if npc.position.y < pc.position.y then y = 1 end
  if npc.position.y > pc.position.y then y = -1 end

  dispatch(character.actions.move(npc, Position(npc.position.x + x, npc.position.y + y, npc.position.z)))
end

function Behaviors.randomMovement(char, dispatch)
  local Position = require "game.rules.world.position"
  local character = require "game.rules.character"
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)

  dispatch(character.actions.move(char, Position(char.position.x + x, char.position.y + y, char.position.z)))
end

return Behaviors