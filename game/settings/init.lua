-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    setOption = require "game.settings.actions.set_option",
    toggleOption = require "game.settings.actions.toggle_option"
  },
  selectors = {
    getOption = require "game.settings.selectors.get_option"
  }

}