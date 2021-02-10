-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local Character = require "game.rules.character"

local function createSuccessResult(dispatch, _, defender, _)
  return function()
    dispatch(Character.actions.setHealth(defender, defender.health - 1))
  end
end

local function createMissResult(_, _, _, _)
  return function()
  end
end

return function(attacker, defender, item)
  return function(_, dispatch)
    -- Figure out skill and perform check
    local skill = Skills.list[item.skills[1]]
    local performAttack = Skills.actions.perform(
      skill, attacker,
      createSuccessResult(dispatch, attacker, defender, item),
      createMissResult(dispatch, attacker, defender, item)
    )
    dispatch(performAttack)
  end
end