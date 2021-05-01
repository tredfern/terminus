-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.selectors.get_field_of_view", function()
  local getFoV = require "game.rules.player.selectors.get_field_of_view"

  it("finds the player and then gets its FoV", function()
    local player = { isPlayerControlled = true }
    local fov = { }
    local state = {
      world = {
        player
      },
      fieldOfView = {
        [player] = fov
      }
    }

    assert.equals(fov, getFoV(state))
  end)
end)