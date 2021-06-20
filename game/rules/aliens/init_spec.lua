-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.aliens", function()
  local Aliens = require "game.rules.aliens"

  it("provides the standard API", function()
    assert.not_nil(Aliens.actions)
    assert.not_nil(Aliens.selectors)
    assert.not_nil(Aliens.types)
  end)
end)