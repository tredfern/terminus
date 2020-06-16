-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local action_types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

return function(state, action)
  state = state or {}
  if action == nil then return state end

  if action.type == action_types.message_add then
    return tables.concat_array(state, { action.payload })
  end

  return state
end