-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    addEntity = require "game.rules.world.actions.add_entity",
    removeEntity = require "game.rules.world.actions.remove_entity"
  },
  selectors = {
    getAllWithComponents = require "game.rules.world.selectors.get_all_with_components"
  }
}