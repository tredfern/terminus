-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    add = require "game.rules.map.actions.add",
    create = require "game.rules.map.actions.create",
    types = require "game.rules.map.actions.types"
  },
  generators = {
    dungeon = require "game.rules.map.generators.dungeon"
  },
  selectors = {
    getDimensions = require "game.rules.map.selectors.get_dimensions",
    getRooms = require "game.rules.map.selectors.get_rooms",
    getTerrain = require "game.rules.map.selectors.get_terrain"
  },
  tileMap = require "game.rules.map.tile_map",
  outline = require "game.rules.map.outline"
}