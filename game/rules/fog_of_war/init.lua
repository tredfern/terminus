-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    updatePerspective = require "game.rules.fog_of_war.actions.update_perspective",
    updatePosition = require "game.rules.fog_of_war.actions.update_position"
  },
  selectors = {
    get = require "game.rules.fog_of_war.selectors.get"
  }
}