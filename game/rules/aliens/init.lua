-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    addSpawner = require "game.rules.aliens.actions.add_spawner",
    removeSpawner = require "game.rules.aliens.actions.remove_spawner"
  },
  selectors = {
    getSpawnerAt = require "game.rules.aliens.selectors.get_spawner_at",
    getSpawners = require "game.rules.aliens.selectors.get_spawners"
  }
}