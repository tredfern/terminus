-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local factory = require "game.rules.character.factory"


return {
  actions = {
    add = require "game.rules.character.actions.add",
    addItemToInventory = require "game.rules.character.actions.add_item_to_inventory",
    equipItem = require "game.rules.character.actions.equip_item",
    move = require "game.rules.character.actions.move",
    remove = require "game.rules.character.actions.remove",
    setHealth = require "game.rules.character.actions.set_health",
    setName = require "game.rules.character.actions.set_name",
    setPosition = require "game.rules.character.actions.set_position",
    types = require "game.rules.character.actions.types"
  },
  attributes = require "game.rules.character.attributes",
  create = factory.newCharacter,
  reducer = require "game.rules.character.reducer",
  selectors = {
    getAll = require "game.rules.character.selectors.get_all",
    getByPosition = require "game.rules.character.selectors.get_by_position",
    getDead = require "game.rules.character.selectors.get_dead",
    getEnemies = require "game.rules.character.selectors.get_enemies",
    getPlayer = require "game.rules.character.selectors.get_player",
  }
}