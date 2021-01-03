-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.reducer", function()
  local characters_reducer = require "game.rules.character.reducer"
  local types = require "game.rules.character.actions.types"

  it("adds new characters to the store through the character_add action", function()
    local new_char = {}
    local add = {
      type = types.character_add,
      payload = {
        character = new_char
      }
    }

    local new_state = characters_reducer({}, add)
    assert.array_includes(new_char, new_state)
  end)

  it("returns the same state if the action is not handled", function()
    local state = {}
    assert.equals(state, characters_reducer(state, { type = "random_action" }))
  end)

  it("moves the character to the specified position", function()
    local character = { x = 3, y = 8 }
    local state = { character }
    local action = { type = types.character_move,
      payload = {
        character = character,
        x = 4,
        y = 9
      }
    }

    local new_state = characters_reducer(state, action)
    local c = new_state[1]
    assert.equals(character, c)
    assert.equals(4, c.x)
    assert.equals(9, c.y)
  end)
end)