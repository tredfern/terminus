-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"

return function(direction)
  return function(dispatch, getState)
    local findPlayer = require "game.rules.player.selectors.get_player"
    local player = findPlayer(getState())

    local x, y = direction(player.position.x, player.position.y)
    dispatch(characters.actions.move(player, x, y))
  end
end