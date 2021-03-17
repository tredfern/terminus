-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.npcs", function()
  local npcs = require "game.rules.npcs"

  it("has selectors to return different npc types", function()
    assert.not_nil(npcs.selectors.getEnemies)
  end)
end)