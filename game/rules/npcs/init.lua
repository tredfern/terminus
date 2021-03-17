-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    think = require "game.rules.npcs.actions.think"
  },
  selectors = {
    getEnemies = require "game.rules.npcs.selectors.get_enemies"

  }
}