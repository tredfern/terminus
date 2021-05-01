-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  local getPlayer = require "game.rules.player.selectors.get_player"
  local FOV = require "game.rules.field_of_view"

  local p = getPlayer(state)
  return FOV.selectors.get(state, p)
end