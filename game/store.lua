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
    fieldOfView = require "game.rules.field_of_view.reducer",
    fogOfWar = require "game.rules.fog_of_war.reducer",
    graphics = require "game.rules.graphics.reducer",
    items = require "game.rules.items.reducer",
    map = require "game.rules.map.reducer",
    message_log = require "game.rules.message_log.reducer",
    settings = require "game.settings.reducer",
    turn = require "game.rules.turn.reducer",
    world = require "game.rules.world.reducer"
  }
end

store.reset = function(state)
  store.createStore(
    getReducers(),
    state
  )
end

store.dumpState = function()
  local printTable = require "moonpie.utility.print_table"
  local stateString = printTable(store.getState())
  love.filesystem.write("game_state.dump", stateString)
end

store.reset()
store.logFilterFor("CHARACTER_ADD", "CHARACTER_REMOVE", "ITEMS_REMOVE", "ITEMS_ADD", "CHARACTER_SET_ATTRIBUTE")

return store