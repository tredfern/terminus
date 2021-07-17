-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.bestiary", function()
  local Bestiary = require "game.rules.bestiary"

  it("has actions and selectors", function()
    assert.not_nil(Bestiary.actions)
    assert.not_nil(Bestiary.selectors)
  end)
end)