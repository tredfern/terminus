-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = require "game.rules.map.actions",
  generators = {
    dungeon = require "game.rules.map.generators.dungeon"
  },
  selectors = require "game.rules.map.selectors",
}