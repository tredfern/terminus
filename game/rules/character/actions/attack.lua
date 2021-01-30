-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local set_health = require "game.rules.character.actions.set_health"
local types = require "game.rules.character.actions.types"
local message_log = require "game.rules.message_log"

return function(source, target)
  if source == target then return {} end

  return setmetatable({
    type = types.character_attack,
  }, {
    __call = function(_, dispatch)
      dispatch(set_health(target, target.health - 1))

      -- Message Log Entry
      local src = source.name or tostring(source)
      local trg = target.name or tostring(target)
      local str = src .. " attacked " .. trg
      dispatch(message_log.actions.add(str))
    end
  })
end