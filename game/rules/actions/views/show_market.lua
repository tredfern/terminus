-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local action = require "game.rules.actions.game_view_set"
local market = require "game.ui.views.market_view"

return function()
  return action(market())
end