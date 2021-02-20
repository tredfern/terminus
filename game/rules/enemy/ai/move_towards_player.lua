-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"


return function(npc, dispatch, getState)
  local player = character.selectors.getPlayer(getState())

  local x = 0
  if npc.x < player.x then x = 1 end
  if npc.x > player.x then x = -1 end

  local y = 0
  if npc.y < player.y then y = 1 end
  if npc.y > player.y then y = -1 end

  dispatch(character.actions.move(npc, npc.x + x, npc.y + y))

end