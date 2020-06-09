-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local combine_reducers = require "moonpie.redux.combine_reducers"

return combine_reducers{
  spaceports = require "game.rules.reducers.spaceports",
  location = require "game.rules.reducers.location",
  player_cargo = require "game.rules.reducers.cargo",
  market_items = require "game.rules.reducers.market",
  player = require "game.rules.reducers.player"
}