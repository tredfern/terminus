-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local action_types = require "game.rules.actions.types"
return function(name)
  return {
    payload = name,
    type = action_types.character.name_update
  }
end