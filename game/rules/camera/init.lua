-- Copyright (c) 2021 Trevor Redfern
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    set_position = require "game.rules.camera.actions.set_position"
  },
  selectors = {
    get = require "game.rules.camera.selectors.get"
  }
}