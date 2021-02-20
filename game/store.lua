-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local combine_reducers = require "moonpie.redux.combine_reducers"

local function getReducers()
  return combine_reducers {
    camera = require "game.ui.camera.reducer",
    characters = require "game.rules.character.reducer",
    items = require "game.rules.items.reducer",
    map = require "game.rules.map.reducer",
    message_log = require "game.rules.message_log.reducer",
    settings = require "game.settings.reducer",
    turn = require "game.rules.turn.reducer"
  }
end

store.reset = function(state)
  store.createStore(
    getReducers(),
    state
  )
end

store.reset()

return store