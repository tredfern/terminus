-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens", function()
  local Aliens = require "game.rules.aliens"

  it("has actions", function()
    assert.not_nil(Aliens.actions.addSpawner)
    assert.not_nil(Aliens.actions.removeSpawner)
  end)

  it("has selectors", function()
    assert.not_nil(Aliens.selectors.getSpawners)
    assert.not_nil(Aliens.selectors.getSpawnerAt)
  end)
end)