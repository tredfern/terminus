-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.events.types"

return function(situation)
  return {
    type = types.combat_start,
    payload = situation
  }
end