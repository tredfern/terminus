-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local combine_reducers = require "moonpie.redux.combine_reducers"

store.create_store(
  combine_reducers {
    camera = require "game.rules.camera.reducer",
    characters = require "game.rules.character.reducer",
    map = require "game.rules.map.reducer",
    turn = require "game.rules.turn.reducer"
  }
)

return store