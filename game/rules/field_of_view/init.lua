-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    calculate = require "game.rules.field_of_view.actions.calculate",
    calculateAll = require "game.rules.field_of_view.actions.calculate_all",
    update = require "game.rules.field_of_view.actions.update"
  },
  selectors = {
    get = require "game.rules.field_of_view.selectors.get"
  }
}