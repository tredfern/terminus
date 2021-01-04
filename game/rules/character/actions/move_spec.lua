-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.move", function()
  local character_move = require "game.rules.character.actions.move"
  local types = require "game.rules.character.actions.types"

  it("dispatches a set_position message to move the character to the correct coordinates", function()
    local c = {}
    local action = character_move(c, 19, 10)
    local dispatched
    local dispatch = spy.new(function(d) dispatched = d end)
    local state = {}

    action(dispatch, state)
    assert.equals(types.character_set_position, dispatched.type)
  end)
end)