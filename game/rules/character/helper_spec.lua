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

  it("has a defense of 50", function()
    local c = characterHelper.newCharacter {}
    assert.equals(50, c.defense)
  end)

  it("has an attack of 50", function()
    local c= characterHelper.newCharacter {}
    assert.equals(50, c.attack)
  end)

  it("sets up default abilities", function()
    local c = characterHelper.newCharacter()

    assert.in_range(3, 18, c.abilities.strength)
    assert.in_range(3, 18, c.abilities.agility)
    assert.in_range(3, 18, c.abilities.endurance)
    assert.in_range(3, 18, c.abilities.wit)
    assert.in_range(3, 18, c.abilities.education)
    assert.in_range(3, 18, c.abilities.social)
  end)

  it("sets up some default skills", function()
    local c = characterHelper.newCharacter()

    assert.in_range(3, 18, c.skills.throwing:getScore())
    assert.in_range(3, 18, c.skills.unarmed:getScore())
    assert.in_range(3, 18, c.skills.blade:getScore())
    assert.in_range(3, 18, c.skills.handgun:getScore())

  end)
end)