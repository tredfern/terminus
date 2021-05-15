-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.actions.animation_play_once", function()
  local animationPlayOnce = require "game.rules.graphics.actions.animation_play_once"

  it("describes an animation to play", function()
    local animator = {}

    local action = animationPlayOnce(animator, "myAnimation")
    assert.equals("ANIMATION_PLAY_ONCE", action.type)
    assert.equals(animator, action.payload.animator)
    assert.equals("myAnimation", action.payload.animation)
  end)
end)