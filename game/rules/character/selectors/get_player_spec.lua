-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_player", function()
  local get_player = require "game.rules.character.selectors.get_player"

  it("can search state and return the player character if it exists", function()
    local player = { is_player_controlled = true }
    local state = {
      characters = {
        player
      }
    }

    assert.equals(player, get_player(state))
  end)


end)