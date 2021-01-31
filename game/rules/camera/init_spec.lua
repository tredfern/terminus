-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.camera", function()
  local camera = require "game.rules.camera"

  it("has actions available", function()
    assert.not_nil(camera.actions.centerOnPlayer)
    assert.not_nil(camera.actions.setDimensions)
    assert.not_nil(camera.actions.setPosition)
  end)

  it("has selectors available", function()
    assert.not_nil(camera.selectors.get)
  end)
end)