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
    heal = require "game.rules.character.actions.heal",
    move = require "game.rules.character.actions.move",
    pickupItems = require "game.rules.character.actions.pickup_items",
    remove = require "game.rules.character.actions.remove",
    removeItemFromInventory = require "game.rules.character.actions.remove_item_from_inventory",
    setAttribute = require "game.rules.character.actions.set_attribute",
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