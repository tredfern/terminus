-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local increment = require "game.rules.turn.actions.increment"
return function(player_action)
  return function(dispatch)
    dispatch(increment())
    dispatch(player_action)
  end
end