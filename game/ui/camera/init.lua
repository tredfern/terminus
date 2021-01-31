-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    centerOnPlayer = require "game.ui.camera.actions.center_on_player",
    setDimensions = require "game.ui.camera.actions.set_dimensions",
    setPosition = require "game.ui.camera.actions.set_position"
  },
  selectors = {
    get = require "game.ui.camera.selectors.get"
  }
}