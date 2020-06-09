-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local tables = require "moonpie.tables"

local mock_reducer = function(state, action)
  return tables.assign({}, state, {
    actions = tables.concat_array(state.actions, { action })
  })
end

function store.get_action_groups()
  local actions = store.get_state().actions or {}
  return moonpie.utility.tables.group_by(actions, function(a) return a.type end)
end


return function(stub_state)
  store.create_store(mock_reducer, stub_state)
  return store
end