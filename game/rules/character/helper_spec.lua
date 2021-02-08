-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.character", function()
  local characterHelper = require "game.rules.character.helper"

  it("instantiates a new character", function()
    local c = characterHelper.newCharacter()
    assert.equals(0, c.x)
    assert.equals(0, c.y)
  end)

  it("can be player controlled", function()
    local c = characterHelper.newCharacter { isPlayerControlled = true }
    assert.is_true(c.isPlayerControlled)
  end)

  it("can be identified as an enemy", function()
    local c = characterHelper.newCharacter { isEnemy = true }
    assert.is_true(c.isEnemy)
  end)

  it("can initialize it's position", function()
    local c = characterHelper.newCharacter { x = 142, y = 192 }
    assert.equals(142, c.x)
    assert.equals(192, c.y)
  end)

  it("has a health of 10 to start", function()
    local c = characterHelper.newCharacter {}
    assert.equals(10, c.health)
  end)

  it("sets up default attributes", function()
    local attributes = require "game.rules.character.attributes"
    local c = characterHelper.newCharacter()

    assert.in_range(3, 18, c.attributes[attributes.strength])
    assert.in_range(3, 18, c.attributes[attributes.agility])
    assert.in_range(3, 18, c.attributes[attributes.endurance])
    assert.in_range(3, 18, c.attributes[attributes.wit])
    assert.in_range(3, 18, c.attributes[attributes.education])
    assert.in_range(3, 18, c.attributes[attributes.social])
  end)

  it("sets up an empty inventory", function()
    local c = characterHelper.newCharacter()
    assert.equals(0, #c.inventory)
  end)

  it("sets up the equipment slots on the inventory", function()
    local c = characterHelper.newCharacter()
    assert.not_nil(c.inventory.equipSlots)
  end)
end)