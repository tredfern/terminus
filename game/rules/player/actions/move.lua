-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"

return function(direction)
  return function(dispatch, getState)
    local findPlayer = require "game.rules.player.selectors.get_player"
    local player = findPlayer(getState())

    local newPos = direction(player.position)
    dispatch(characters.actions.move(player, newPos))
  end
end