-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local create_slice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"

return create_slice {
  [types.character_add] = function(state, action)
    return tables.concat_array(state, { action.payload.character })
  end
}