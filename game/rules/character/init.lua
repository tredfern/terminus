-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local factory = require "game.rules.character.factory"


return {
  actions = {
    add = require "game.rules.character.actions.add",
    heal = require "game.rules.character.actions.heal",
    move = require "game.rules.character.actions.move",
    remove = require "game.rules.character.actions.remove",
    setAttribute = require "game.rules.character.actions.set_attribute",
    setHealth = require "game.rules.character.actions.set_health",
    setName = require "game.rules.character.actions.set_name",
    setPosition = require "game.rules.character.actions.set_position",
    types = require "game.rules.character.actions.types"
  },
  attributes = require "game.rules.character.attributes",
  create = factory.newCharacter,
  reducer = require "game.rules.character.reducer",
  selectors = require "game.rules.character.selectors"
}