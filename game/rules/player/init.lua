-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Player = {
  actions = require "game.rules.player.actions",
  reducer = require "game.rules.player.reducer",
  selectors = require "game.rules.player.selectors"
}

return Player