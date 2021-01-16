-- Copyright (c) 2021 Trevor Redfern
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera", function()
  local camera = require "game.rules.camera"

  it("has actions available", function()
    assert.not_nil(camera.actions.set_position)
  end)

  it("has selectors available", function()
    assert.not_nil(camera.selectors.get)
  end)
end)