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

local metaData = {
  [Attributes.strength] = { displayText = "Strength", abbr = "STR" },
  [Attributes.dexterity] = { displayText = "Dexterity", abbr = "DEX" },
  [Attributes.endurance] = { displayText = "Endurance", abbr = "END" },
  [Attributes.intelligence] = { displayText = "Intelligence", abbr = "INT" },
  [Attributes.knowledge] = { displayText = "Knowledge", abbr = "KNW" },
  [Attributes.charisma] = { displayText = "Charisma", abbr = "CHA" },
}

function Attributes.getDisplayText(attr)
  return metaData[attr].displayText
end

function Attributes.roll()
  local Dice = require "moonpie.math.dice"
  return Dice.cup(Dice.d6, Dice.d6)()
end

function Attributes.pointBuyStart()
  return { 4, 5, 6, 7, 8, 9 }
end

function Attributes.pointBuyMinimum()
  return 3
end

function Attributes.pointBuyMaximum()
  return 12
end

return Attributes