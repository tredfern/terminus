-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
return function(spaceport)
  return {
    type = types.spaceport_add,
    payload = spaceport
  }
end