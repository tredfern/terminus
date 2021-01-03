-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character", function()
  local character = require "game.rules.character"

  it("has an entity that can be instantiated", function()
    local c = character.create {
      is_player_controlled = true,
      x = 3,
      y = 4
    }

    assert.not_nil(c)
    assert.equals(3, c.x)
  end)

  it("has selectors to find characters", function()
    assert.not_nil(character.selectors)
  end)

  it("has a reducer that can handle state changes", function()
    assert.not_nil(character.reducer)
  end)

  it("has the actions that can be used with the character", function()
    assert.is_table(character.actions)
    assert.is_table(character.actions.types)
  end)

end)