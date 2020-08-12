-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

return function(state, action)
  state = state or {}
  if action == nil then return state end

  if action.type == types.game_view_set then
    return tables.assign(state, { current = action.payload })
  end

  if action.type == types.game_view_action_add then
    local actions = tables.concat_array(state.actions, { action.payload })
    return tables.assign(state, { actions = actions })
  end
  return state
end