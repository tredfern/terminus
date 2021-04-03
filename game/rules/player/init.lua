-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    add = require "game.rules.player.actions.add",
    equipItem = require "game.rules.player.actions.equip_item",
    move = require "game.rules.player.actions.move",
    pickupItems = require "game.rules.player.actions.pickup_items",
  },
  selectors = {
    getPlayer = require "game.rules.player.selectors.get_player"
  }
}