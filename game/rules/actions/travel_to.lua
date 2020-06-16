-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local location_update = require "game.rules.actions.location_update"
local message_add = require "game.rules.actions.message_add"
return function(destination)
  return function(dispatch)
    dispatch(message_add(string.format("Leaving for: %s", destination.name)))
    dispatch(location_update(destination))
    dispatch(message_add(string.format("Arriving at: %s", destination.name)))
  end
end