-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    updateFrame = require "game.rules.graphics.actions.update_frame"
  },
  selectors = {
    getAnimatedEntities = require "game.rules.graphics.selectors.get_animated_entities",
    getDrawable = require "game.rules.graphics.selectors.get_drawable"
  }
}