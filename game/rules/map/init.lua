-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local mapHelper = require "game.rules.map.helper"

return {
  actions = {
    addEnemySpawner = require "game.rules.map.actions.add_enemy_spawner",
    set = require "game.rules.map.actions.set",
    types = require "game.rules.map.actions.types"
  },
  create = function(w, h)
    return mapHelper:new {
      width = w,
      height = h
    }
  end,
  generators = {
    dungeon = require "game.rules.map.generators.dungeon"
  },
  selectors = {
    getDimensions = require "game.rules.map.selectors.get_dimensions",
    getEnemySpawners = require "game.rules.map.selectors.get_enemy_spawners",
    getRooms = require "game.rules.map.selectors.get_rooms",
    getTerrain = require "game.rules.map.selectors.get_terrain"
  }
}