-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    animationPlayOnce = require "game.rules.graphics.actions.animation_play_once",
    updateFrame = require "game.rules.graphics.actions.update_frame"
  },
  reducer = require "game.rules.graphics.reducer",
  selectors = {
    getAnimatedEntities = require "game.rules.graphics.selectors.get_animated_entities",
    getDrawable = require "game.rules.graphics.selectors.get_drawable"
  },
}