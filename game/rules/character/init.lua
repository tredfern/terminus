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
    setName = require "game.rules.character.actions.set_name",
    setPosition = require "game.rules.character.actions.set_position",
    types = require "game.rules.character.actions.types"
  },
  create = function(props) return character:new(props) end,
  reducer = require "game.rules.character.reducer",
  selectors = {
    getAll = require "game.rules.character.selectors.get_all",
    getByPosition = require "game.rules.character.selectors.get_by_position",
    getDead = require "game.rules.character.selectors.get_dead",
    getEnemies = require "game.rules.character.selectors.get_enemies",
    getPlayer = require "game.rules.character.selectors.get_player",
  }
}