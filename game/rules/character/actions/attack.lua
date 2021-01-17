-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local set_health = require "game.rules.character.actions.set_health"
local types = require "game.rules.character.actions.types"

return function(source, target)
  if source == target then return {} end

  return setmetatable({
    type = types.character_attack,
  }, {
    __call = function(_, dispatch)
      dispatch(set_health(target, target.health - 1))
    end
  })
end