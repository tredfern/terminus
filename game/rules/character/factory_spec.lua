-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.character", function()
  local characterFactory = require "game.rules.character.factory"
  local attributes = require "game.rules.character.attributes"

  it("instantiates a new character", function()
    local c = characterFactory.newCharacter()
    assert.equals(0, c.position.x)
    assert.equals(0, c.position.y)
  end)

  it("can be player controlled", function()
    local c = characterFactory.newCharacter { isPlayerControlled = true }
    assert.is_true(c.isPlayerControlled)
  end)

  it("can be identified as an enemy", function()
    local c = characterFactory.newCharacter { isEnemy = true }
    assert.is_true(c.isEnemy)
  end)

  it("can initialize it's position", function()
    local c = characterFactory.newCharacter { position = { x = 142, y = 192 } }
    assert.equals(142, c.position.x)
    assert.equals(192, c.position.y)
  end)

  it("has a health of 10 + endurance to start", function()
    local c = characterFactory.newCharacter()
    assert.equals(10 + c.attributes[attributes.endurance], c.health)
  end)

  it("sets up default attributes", function()
    local c = characterFactory.newCharacter()

    assert.in_range(2, 12, c.attributes[attributes.strength])
    assert.in_range(2, 12, c.attributes[attributes.dexterity])
    assert.in_range(2, 12, c.attributes[attributes.endurance])
    assert.in_range(2, 12, c.attributes[attributes.intelligence])
    assert.in_range(2, 12, c.attributes[attributes.knowledge])
    assert.in_range(2, 12, c.attributes[attributes.charisma])
  end)

  it("gives the character a name", function()
    local c = characterFactory.newCharacter()
    assert.not_nil(c.name)
    assert.is_string(c.name)
  end)

  it("can have an ai routine assigned to it", function()
    local aiRoutine = function() end
    local c = characterFactory.newCharacter {
      ai = aiRoutine
    }

    assert.equals(aiRoutine, c.ai)
  end)

  it("starts with some buy points for attributes", function()
    local c= characterFactory.newCharacter()
    assert.greater_than(0, c.attributes.buyPoints)
  end)
end)