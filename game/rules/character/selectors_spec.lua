-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.characters.selectors", function()
  local Selectors = require "game.rules.character.selectors"
  local Attributes = require "game.rules.character.attributes"

  describe("SELECTOR: getAll", function()
    it("returns all characters from state as an array", function()
      local c1,c2,c3 = {}, {}, {}
      local state = {
        characters = {
          c1, c2, c3
        }
      }

      assert.array_matches({ c1, c2, c3 }, Selectors.getAll(state))
    end)

    it("returns an empty array if characters is not assigned in state", function()
      assert.same({}, Selectors.getAll({}))
    end)
  end)

  describe("SELECTOR: getAttribute", function()
    it("returns the specific attribute", function()
      local c = { attributes = { STRENGTH = 32 } }
      assert.equals(32, Selectors.getAttribute({}, c, Attributes.strength))
    end)
  end)

  describe("SELECTOR: getByPosition", function()
    local Position = require "game.rules.world.position"

    it("returns any characters from the state that match the coordinates", function()
      local find1 = { position = Position.new(38, 20) }
      local find2 = { position = Position.new(38, 20) }
      local skip1 = { position = Position.new(12, 22) }
      local skip2 = { position = Position.new(48, 11) }

      local state = {
        characters = {
          find1, skip2, skip1, find2
        }
      }
      local results = Selectors.getByPosition(state, Position(38, 20))

      assert.array_includes(find1, results)
      assert.array_includes(find2, results)
      assert.not_array_includes(skip1, results)
      assert.not_array_includes(skip2, results)
    end)
  end)

  describe("SELECTOR: getDead", function()
    it("return all characters that have a health of 0", function()
      local alive = { health = 1 }
      local dead1 = { health = 0 }
      local dead2 = { health = -4 }
      local state = {
        characters = {
          alive, dead1, dead2
        }
      }

      local results = Selectors.getDead(state)
      assert.equals(2, #results)
      assert.array_includes(dead1, results)
      assert.array_includes(dead2, results)
    end)
  end)

  describe("SELECTORS for Attributes", function()
    local c = {
      attributes = {
        [Attributes.strength] = 2,
        [Attributes.dexterity] = 3,
        [Attributes.endurance] = 6,
        [Attributes.knowledge] = 9,
        [Attributes.intelligence] = 12,
        [Attributes.charisma] = 15,
        buyPoints = 5
      }
    }
    local state = { characters = { c } }

    it("can return the modifiers for the character stats", function()
      assert.equals(-2, Selectors.getStrengthModifier({}, c))
      assert.equals(-1, Selectors.getDexterityModifier({}, c))
      assert.equals(0, Selectors.getEnduranceModifier({}, c))
      assert.equals(1, Selectors.getKnowledgeModifier({}, c))
      assert.equals(2, Selectors.getIntelligenceModifier({}, c))
      assert.equals(3, Selectors.getCharismaModifier({}, c))
    end)

    it("returns nil for the modifier if no value is set", function()
      assert.is_nil(Selectors.getStrengthModifier({}, {}))
    end)

    it("returns nil for an attribute if attributes do not exist", function()
      assert.is_nil(Selectors.getAttribute({}, {}, Attributes.strength))
    end)

    it("can get all the attributes together", function()
      local attr = Selectors.getAttributes(state, c)
      assert.equals(2, attr[Attributes.strength].value)
      assert.equals(-2, attr[Attributes.strength].modifier)
      assert.equals(3, attr[Attributes.dexterity].value)
      assert.equals(-1, attr[Attributes.dexterity].modifier)
      assert.equals(6, attr[Attributes.endurance].value)
      assert.equals(0, attr[Attributes.endurance].modifier)
      assert.equals(9, attr[Attributes.knowledge].value)
      assert.equals(1, attr[Attributes.knowledge].modifier)
      assert.equals(12, attr[Attributes.intelligence].value)
      assert.equals(2, attr[Attributes.intelligence].modifier)
      assert.equals(15, attr[Attributes.charisma].value)
      assert.equals(3, attr[Attributes.charisma].modifier)
    end)

    it("can return the buy points available", function()
      assert.equals(5, Selectors.getBuyPoints(state, c))
    end)
  end)

  describe("SELECTORS: getName", function()
    local c = {
      name = "Foo Bar"
    }
    local state = {
      characters = { c }
    }

    assert.equals("Foo Bar", Selectors.getName(state, c))
  end)
end)