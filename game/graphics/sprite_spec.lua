-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.graphics.sprite", function()
  local sprite = require "game.graphics.sprite"

  it("can accept an image file", function()
    local img = {}
    local test = sprite.fromImage(img)
    assert.not_nil(test)
    assert.equals(img, test:currentImage())
  end)
end)