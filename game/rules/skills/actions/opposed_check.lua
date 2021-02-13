-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local skillCheck = Dice.cup(Dice.d6, Dice.d6, Dice.d6)
local MessageLog = require "game.rules.message_log"
local msgFormat = "%s(%s:%d/%d) vs. %s(%s:%d/%d)"

return function(aggressor, aggSkill, defender, defSkill, callback)
  return function(dispatch)
    local aggTarget = aggSkill(aggressor)
    local defTarget = defSkill(defender)

    local aggRoll = skillCheck()
    local defRoll = skillCheck()
    local aggSucceed = aggRoll < aggTarget
    local defSucceed = defRoll < defTarget

    dispatch(MessageLog.actions.add(
      string.format(msgFormat,
        aggressor.name, aggSkill.name, aggRoll, aggTarget,
        defender.name, defSkill.name, defRoll, defTarget)
    ))

    if aggSucceed and not defSucceed then
      callback(aggressor, defender)
    else
      callback(defender, aggressor)
    end
  end
end