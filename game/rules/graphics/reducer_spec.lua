-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.reducer", function()
  local reducer = require "game.rules.graphics.reducer"

  it("can play an animation once", function()
    local animator = {
      playOnce = spy.new(function() end)
    }
    local action = {
      type = "ANIMATION_PLAY_ONCE",
      payload = {
        animator = animator,
        animation = "wave"
      }
    }

    reducer({}, action)

    assert.spy(animator.playOnce).was.called_with(animator, "wave")
  end)
end)