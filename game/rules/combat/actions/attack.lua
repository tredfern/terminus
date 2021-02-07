-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.combat.actions.types"
local message_log = require "game.rules.message_log"

local function performRoll(score)
  local roll = math.random(20)
  return roll <= score, roll
end

return function(source, target)
  local Character = require "game.rules.character"
  if source == target then return {} end

  return setmetatable({
    type = types.combat_attack,
  }, {
    __call = function(_, dispatch)
      local skill = Character.skills.unarmed(source)
      local hit, attackRoll = performRoll(skill)

      if hit then
        dispatch(Character.actions.setHealth(target, target.health - 1))
      end

      -- Message Log Entry
      local src = source.name or tostring(source)
      local trg = target.name or tostring(target)
      local str = string.format(
        "%s attacked %s and %s! (%d/%d)",
        src, trg, hit and "Hit" or "Missed", attackRoll, skill)
      dispatch(message_log.actions.add(str))
    end
  })
end