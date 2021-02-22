-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local tables = require "moonpie.tables"

local mock_reducer = function(state, action)
  return tables.assign({}, state, {
    actions = tables.concatArray(state.actions, { action })
  })
end

function store.get_action_groups()
  local actions = store.getState().actions or {}
  return moonpie.utility.tables.groupBy(actions, function(a) return a.type end)
end

function store.get_actions(type)
  local groups = store.get_action_groups()
  return groups[type]
end

function store.receivedAction(type)
  return #store.get_actions(type) > 1
end

return function(stub_state)
  store.createStore(mock_reducer, stub_state)
  return store
end