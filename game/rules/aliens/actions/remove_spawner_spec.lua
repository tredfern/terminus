-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens.actions.remove_spawner", function()
  local removeSpawner = require "game.rules.aliens.actions.remove_spawner"

  it("identifies the spawner to remove", function()
    local spawner = {}

    local action = removeSpawner(spawner)
    assert.equals(spawner, action.payload.entity)
  end)
end)