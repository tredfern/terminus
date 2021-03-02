-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    checkGameOver = require "game.rules.game_state.actions.check_game_over",
    gameOver = require "game.rules.game_state.actions.game_over",
    loadCoreData = require "game.rules.game_state.actions.load_core_data",
    setup = require "game.rules.game_state.actions.setup"
  }

}