-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Files = require "moonpie.utility.files"

return {
  actions = {
    setOption = require "game.settings.actions.set_option",
    toggleOption = require "game.settings.actions.toggle_option"
  },
  assetPath = function(assetName)
    return Files.mergePath("assets", assetName)
  end,
  selectors = {
    getOption = require "game.settings.selectors.get_option"
  }

}