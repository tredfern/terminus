-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    add = require "game.rules.message_log.actions.add"
  },
  selectors = {
    getLast = require "game.rules.message_log.selectors.get_last"
  }
}