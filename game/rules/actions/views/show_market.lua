-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local game_view = require "game.rules.actions.game_view_set"
local add_action = require "game.rules.actions.game_view_action_add"
local market = require "game.ui.views.market_view"

return function()
  return function(dispatch)
    dispatch(game_view(market()))
    dispatch(add_action("Leave Store", function() end))
  end
end