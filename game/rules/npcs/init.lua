-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    checkSpawnEnemy = require "game.rules.npcs.actions.check_spawn_enemy",
    think = require "game.rules.npcs.actions.think"
  },
  selectors = {
    getEnemies = require "game.rules.npcs.selectors.get_enemies"

  }
}