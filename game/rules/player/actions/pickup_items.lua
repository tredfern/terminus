-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"
local findPlayer = require "game.rules.player.selectors.get_player"

return function()
  return function(dispatch, getState)
    local pc = findPlayer(getState())

    dispatch(characters.actions.pickupItems(pc))
  end
end