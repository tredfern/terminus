-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    add = require "game.rules.player.actions.add",
    equipItem = require "game.rules.player.actions.equip_item",
    ladderDown = require "game.rules.player.actions.ladder_down",
    ladderUp = require "game.rules.player.actions.ladder_up",
    move = require "game.rules.player.actions.move",
    openDoor = require "game.rules.player.actions.open_door",
    pickupItems = require "game.rules.player.actions.pickup_items",
  },
  selectors = {
    getFieldOfView = require "game.rules.player.selectors.get_field_of_view",
    getPlayer = require "game.rules.player.selectors.get_player",
    hasItemOfKind = require "game.rules.player.selectors.has_item_of_kind"
  }
}