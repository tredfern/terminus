-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local skillCheck = Dice.cup(Dice.d6, Dice.d6, Dice.d6)

return function(skill, character, successCallback, failCallback)
  return function()
    local target = skill(character)
    local roll = skillCheck()
    if roll <= target then
      successCallback(target, roll)
    else
      failCallback(target, roll)
    end
  end
end