-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Player = require "game.rules.player"
local Aliens = require "game.rules.aliens"

return function()
  local gameOver = require "game.rules.game_state.actions.game_over"
  return function(dispatch, getState)
    local state = getState()
    local player = Player.selectors.getPlayer(state)

    if player == nil or player.health <=0 then
      dispatch(gameOver())
    end

    local spawners = Aliens.selectors.getSpawners(state)
    if spawners == nil or #spawners == 0 then
      dispatch(gameOver())
    end
  end
end