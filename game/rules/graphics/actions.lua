-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
local Thunk = require "moonpie.redux.thunk"

function Actions.animationPlayOnce(animator, animation)
  return {
    type = "ANIMATION_PLAY_ONCE",
    payload = {
      animator = animator,
      animation = animation
    }
  }
end

function Actions.updateFrame(deltaTime)
  local Selectors = require "game.rules.graphics.selectors"

  return Thunk("GRAPHICS_UPDATE_FRAME", function(_, getState)
    local state = getState()
    local animators = Selectors.getAnimated(state, "animator")

    for _, v in ipairs(animators) do
      if v.animator.isPlaying then
        v.animator:update(deltaTime)
        v.sprite = v.animator:getCurrentFrame()
      end
    end
  end)
end

return Actions