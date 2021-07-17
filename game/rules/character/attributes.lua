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
  [Attributes.strength] = { displayText = "Strength", abbr = "STR", icon = "strong" },
  [Attributes.dexterity] = { displayText = "Dexterity", abbr = "DEX", icon = "acrobatic" },
  [Attributes.endurance] = { displayText = "Endurance", abbr = "END", icon = "hiking" },
  [Attributes.intelligence] = { displayText = "Intelligence", abbr = "INT", icon = "brain" },
  [Attributes.knowledge] = { displayText = "Knowledge", abbr = "KNW", icon = "diploma"  },
  [Attributes.charisma] = { displayText = "Charisma", abbr = "CHA", icon = "star-struck" },
}

function Attributes.getDisplayText(attr)
  return metaData[attr].displayText
end

function Attributes.getIcon(attr)
  return metaData[attr].icon
end

function Attributes.getAbbreviation(attr)
  return metaData[attr].abbr
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