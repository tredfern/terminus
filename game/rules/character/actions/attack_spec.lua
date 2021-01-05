-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.attack", function()
  local attack = require "game.rules.character.actions.attack"
  local types = require "game.rules.character.actions.types"
  local mock_dispatch = require "mock_dispatch"

  it("removes the target character from the game", function()
    local source, target = {}, {}
    local state = {
      characters = { source, target }
    }
    local atk = attack(source, target)
    atk(mock_dispatch, state)
    assert.is_true(mock_dispatch:received_action(types.character_remove))
  end)
end)