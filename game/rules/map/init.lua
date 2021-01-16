-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local map_entity = require "game.rules.map.map"

return {
  actions = {
    set = require "game.rules.map.actions.set",
    types = require "game.rules.map.actions.types"
  },
  create = function(w, h)
    return map_entity:new {
      width = w,
      height = h
    }
  end

}