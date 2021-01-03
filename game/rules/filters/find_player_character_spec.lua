-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.filters.find_player_character", function()
  local find_player_character = require "game.rules.filters.find_player_character"

  it("can search state and return the player character if it exists", function()
    local player = { is_player_controlled = true }
    local state = {
      characters = {
        player
      }
    }

    assert.equals(player, find_player_character(state))
  end)


end)