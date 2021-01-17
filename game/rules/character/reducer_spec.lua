-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.reducer", function()
  local characters_reducer = require "game.rules.character.reducer"
  local types = require "game.rules.character.actions.types"

  it("returns the same state if the action is not handled", function()
    local state = {}
    assert.equals(state, characters_reducer(state, { type = "random_action" }))
  end)

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

  it("removes the character specified from the array", function()
    local character = {}
    local keep_character = {}
    local state = { character, keep_character }
    local action = { type = types.character_remove, payload = { character = character } }

    local new_state = characters_reducer(state, action)
    assert.not_array_includes(character, new_state)
    assert.array_includes(keep_character, new_state)
  end)

  it("can set the character to the specified position", function()
    local character = { x = 3, y = 8 }
    local state = { character }
    local action = { type = types.character_set_position,
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

  it("can set the character name", function()
    local character = {}
    local state = { character }
    local action = {
      type = types.character_set_name,
      payload = {
        character = character,
        name = "Papageno"
      }
    }

    local new_state = characters_reducer(state, action)
    local c = new_state[1]
    assert.equals("Papageno", c.name)
  end)

  it("sets the initial state to empty table", function()
    local state = characters_reducer(nil, {})
    assert.same(0, #state)
  end)

  it("set the character health", function()
    local character = { health = 84 }
    local state = { characters = { character } }
    local new_state = characters_reducer(state, {
      type = types.character_set_health,
      payload = {
        character = character,
        health = 54
      }
    })

    assert.equals(54, new_state.characters[1].health)
  end)
end)