-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local combine_reducers = require "moonpie.redux.combine_reducers"

return combine_reducers{
  game_view = require "game.rules.reducers.game_view",
  location = require "game.rules.reducers.location",
  market_items = require "game.rules.reducers.market",
  message_log = require "game.rules.reducers.message_log",
  player = require "game.rules.reducers.player",
  player_cargo = require "game.rules.reducers.cargo",
  spaceports = require "game.rules.reducers.spaceports",
}