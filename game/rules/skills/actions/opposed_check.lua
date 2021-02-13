-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local skillCheck = Dice.cup(Dice.d6, Dice.d6, Dice.d6)

return function(aggressor, aggSkill, defender, defSkill, callback)
  return function()
    local aggTarget = aggSkill(aggressor)
    local defTarget = defSkill(defender)

    local aggRoll = skillCheck()
    local defRoll = skillCheck()
    local aggSucceed = aggRoll < aggTarget
    local defSucceed = defRoll < defTarget

    if aggSucceed and not defSucceed then
      callback(aggressor, defender)
    else
      callback(defender, aggressor)
    end
  end
end