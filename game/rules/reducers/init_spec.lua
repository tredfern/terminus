-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers", function()
  local root = require "game.rules.reducers"

  it("has a combined reducer", function()
    assert.not_nil(root)
    assert.is_function(root)
  end)

end)