-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local assign = require "moonpie.tables.assign"

local mock_reducer = function(state, action)
  return assign({}, state, {
    actions = moonpie.utility.tables.concat_array(state.actions, { action })
  })
end

return function(stub_state)
  store.create_store(mock_reducer, stub_state)
  return store
end