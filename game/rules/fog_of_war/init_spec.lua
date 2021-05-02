-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war", function()
  local FogOfWar = require "game.rules.fog_of_war"

  it("has actions", function()
    assert.not_nil(FogOfWar.actions.updatePosition)
  end)
end)