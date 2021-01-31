-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    centerOnPlayer = require "game.rules.camera.actions.center_on_player",
    setDimensions = require "game.rules.camera.actions.set_dimensions",
    setPosition = require "game.rules.camera.actions.set_position"
  },
  selectors = {
    get = require "game.rules.camera.selectors.get"
  }
}