-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics", function()
  local Graphics = require "game.rules.graphics"

  it("has actions for graphics", function()
    assert.not_nil(Graphics.actions.animationPlayOnce)
    assert.not_nil(Graphics.actions.updateFrame)
  end)

  it("has selectors to get all the entities that can be drawn", function()
    assert.not_nil(Graphics.selectors.getAnimated)
    assert.not_nil(Graphics.selectors.getDrawable)
  end)

  it("exports the reducer", function()
    assert.not_nil(Graphics.reducer)
  end)
end)