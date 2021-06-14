-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Attributes = require "game.rules.character.attributes"
local Position = require "game.rules.world.position"
local Selectors = {}

function Selectors.getAll(state)
  if not state.characters then
    return {}
  end

  return tables.select(state.characters, function() return true end)
end

function Selectors.getAttribute(_, character, attribute)
  return character.attributes[attribute]
end

function Selectors.getByPosition(state, position)
  return tables.select(state.characters, function(c)
    return Position.equal(c.position, position)
  end)
end

function Selectors.getDead(state)
  return tables.select(state.characters, function(c)
    return c.health <= 0
  end)
end


function Selectors.getAttributeModifier(_, character, attribute)
  return math.floor(character.attributes[attribute] / 3) - 2
end

function Selectors.getStrengthModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.strength)
end

function Selectors.getDexterityModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.dexterity)
end

function Selectors.getEnduranceModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.endurance)
end

function Selectors.getKnowledgeModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.knowledge)
end

function Selectors.getIntelligenceModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.intelligence)
end

function Selectors.getCharismaModifier(_, character)
  return Selectors.getAttributeModifier(_, character, Attributes.charisma)
end

return Selectors