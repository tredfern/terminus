-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local create_slice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"

return create_slice {
  initial_state = { },
  [types.character_add] = function(state, action)
    return tables.concat_array(state, { action.payload.character })
  end,
  [types.character_remove] = function(state, action)
    return tables.select(state,
    function(character)
      if character ~= action.payload.character then
        return character
      end
    end)
  end,
  [types.character_set_name] = function(state, action)
    local c = action.payload.character
    c.name = action.payload.name
    return state
  end,
  [types.character_set_position] = function(state, action)
    local c = action.payload.character
    c.x = action.payload.x
    c.y = action.payload.y
    return state
  end,
}