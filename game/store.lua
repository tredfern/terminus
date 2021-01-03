-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local combine_reducers = require "moonpie.redux.combine_reducers"

store.create_store(
  combine_reducers {
    character = require "game.rules.character.reducer"
  }
)

return store