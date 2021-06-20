-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.sprite_image", function()
  local SpriteImage = require "game.ui.widgets.sprite_image"

  it("takes a sprite and draws that sprite to the screen when rendering", function()
    local fakeSprite = {
      draw = spy.new(function() end)
    }
    local si = SpriteImage { sprite = fakeSprite }
    si:drawComponent()
    assert.spy(fakeSprite.draw).was.called_with(fakeSprite, 0, 0)
  end)
end)