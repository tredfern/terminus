-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character", function()
  local character = require "game.rules.character"
  local Position = require "game.rules.world.position"

  it("has an entity that can be instantiated", function()
    local c = character.create {
      isPlayerControlled = true,
      position = Position(3, 4, 1)
    }

    assert.not_nil(c)
    assert.equals(3, c.position.x)
  end)

  it("has selectors to retrieve information about characters", function()
    assert.not_nil(character.selectors)
    assert.not_nil(character.selectors.getAll)
    assert.not_nil(character.selectors.getAttribute)
    assert.not_nil(character.selectors.getByPosition)
    assert.not_nil(character.selectors.getDead)
  end)

  it("has a reducer that can handle state changes", function()
    assert.not_nil(character.reducer)
  end)

  it("has the actions that can be used with the character", function()
    assert.is_table(character.actions)
    assert.is_table(character.actions.types)
    assert.not_nil(character.actions.add)
    assert.not_nil(character.actions.heal)
    assert.not_nil(character.actions.move)
    assert.not_nil(character.actions.remove)
    assert.not_nil(character.actions.setAttribute)
    assert.not_nil(character.actions.setHealth)
    assert.not_nil(character.actions.setName)
    assert.not_nil(character.actions.setPosition)
  end)

  it("provides access to the attributes", function()
    assert.not_nil(character.attributes)
  end)

end)