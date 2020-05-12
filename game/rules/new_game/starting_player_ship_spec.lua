-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.new_game.starting_player_ship", function()
  local state = require "game.state"
  local starting_player_ship = require "game.rules.new_game.starting_player_ship"

  it("creates a player ship", function()
    starting_player_ship(state)
    assert.not_nil(state.player)
  end)

  it("gives a basic cargo hold", function()
    starting_player_ship(state)
    assert.not_nil(state.player.cargo_hold)
    assert.equals(15, state.player.cargo_hold.size)
  end)
end)