-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(npc, dispatch, getState)
  local player = require "game.rules.player"
  local character = require "game.rules.character"
  local pc = player.selectors.getPlayerCharacter(getState())

  local x = 0
  if npc.x < pc.x then x = 1 end
  if npc.x > pc.x then x = -1 end

  local y = 0
  if npc.y < pc.y then y = 1 end
  if npc.y > pc.y then y = -1 end

  dispatch(character.actions.move(npc, npc.x + x, npc.y + y))

end