-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.new_game.create_spaceports", function()
  local create_spaceports = require "game.rules.new_game.create_spaceports"
  local state = require "game.state"

  it("sets up an array of spaceports in the state", function()
    create_spaceports(state)

    assert.not_nil(state.spaceports)
    assert.not_empty_array(state.spaceports)
  end)
end)