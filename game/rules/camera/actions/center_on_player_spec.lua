-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera.actions.center_on_player", function()
  local centerOnPlayer = require "game.rules.camera.actions.center_on_player"
  local types = require "game.rules.camera.actions.types"
  local mock_store = require "mock_store"

  it("centers on the player location", function()
    mock_store({
      characters = {
        { is_player_controlled = true, x = 6, y = 19 }
      }
    })

    local action = centerOnPlayer(10, 10)
    assert.equals(types.camera_set_position, action.type)
    assert.equals(1, action.payload.x)
    assert.equals(14, action.payload.y)
  end)

end)