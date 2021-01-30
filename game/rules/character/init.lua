-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character.character"


return {
  actions = {
    add = require "game.rules.character.actions.add",
    move = require "game.rules.character.actions.move",
    remove = require "game.rules.character.actions.remove",
    set_name = require "game.rules.character.actions.set_name",
    set_position = require "game.rules.character.actions.set_position",
    types = require "game.rules.character.actions.types"
  },
  create = function(props) return character:new(props) end,
  reducer = require "game.rules.character.reducer",
  selectors = {
    get_all = require "game.rules.character.selectors.get_all",
    get_by_position = require "game.rules.character.selectors.get_by_position",
    get_dead = require "game.rules.character.selectors.get_dead",
    get_enemies = require "game.rules.character.selectors.get_enemies",
    get_player = require "game.rules.character.selectors.get_player",
  }
}