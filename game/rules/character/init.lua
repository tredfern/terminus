-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character.character"


return {
  actions = {
    add = require "game.rules.character.actions.add",
    move = require "game.rules.character.actions.move",
    types = require "game.rules.character.actions.types"
  },
  create = function(props) return character:new(props) end,
  reducer = require "game.rules.character.reducer",
  selectors = {
    get_player_character = require "game.rules.character.selectors.get_player_character"
  }
}