-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local actions = {
  start = require "game.rules.actions.game_state.start"
}

local statemachine = {}

function statemachine.start()
  store.dispatch(actions.start())
end

function statemachine.current()
  return store.get_state().game_state.current
end

return statemachine
