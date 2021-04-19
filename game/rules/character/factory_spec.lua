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
    local c = characterFactory.newCharacter { x = 142, y = 192 }
    assert.equals(142, c.position.x)
    assert.equals(192, c.position.y)
  end)

  it("has a health of 10 + endurance to start", function()
    local c = characterFactory.newCharacter()
    assert.equals(10 + c.attributes[attributes.endurance], c.health)
  end)

  it("sets up default attributes", function()
    local c = characterFactory.newCharacter()

    assert.in_range(3, 18, c.attributes[attributes.strength])
    assert.in_range(3, 18, c.attributes[attributes.agility])
    assert.in_range(3, 18, c.attributes[attributes.endurance])
    assert.in_range(3, 18, c.attributes[attributes.wit])
    assert.in_range(3, 18, c.attributes[attributes.education])
    assert.in_range(3, 18, c.attributes[attributes.social])
  end)

  it("sets up an empty inventory", function()
    local c = characterFactory.newCharacter()
    assert.equals(0, #c.inventory)
  end)

  it("sets up the equipment slots on the inventory", function()
    local c = characterFactory.newCharacter()
    assert.not_nil(c.inventory.equipSlots)
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
end)