-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.character", function()
  local characters_reducer = require "game.rules.reducers.characters"
  local types = require "game.rules.actions.types"

  it("adds new characters to the store through the character_add action", function()
    local new_char = {}
    local add = {
      type = types.character_add,
      payload = {
        character = new_char
      }
    }

    local new_state = characters_reducer({}, add)
    assert.same({ new_char }, new_state)
    assert.equals(1, #new_state)
  end)

  it("returns the same state if the action is not handled", function()
    local state = {}
    assert.equals(state, characters_reducer(state, { type = "random_action" }))
  end)

  it("updates the character p")

end)