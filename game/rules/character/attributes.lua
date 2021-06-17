-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Attributes = {
  strength = "STRENGTH",
  dexterity = "DEXTERITY",
  endurance = "ENDURANCE",
  intelligence = "INTELLIGENCE",
  knowledge = "KNOWLEDGE",
  charisma = "CHARISMA"
}

function Attributes.roll()
  local Dice = require "moonpie.math.dice"
  return Dice.cup(Dice.d6, Dice.d6)()
end

function Attributes.pointBuyStart()
  return { 4, 5, 6, 7, 8, 9 }
end

return Attributes