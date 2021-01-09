-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.turn.actions.types"

return function()
  return {
    type = types.increment
  }
end