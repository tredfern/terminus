-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local getAnimated = require "game.rules.graphics.selectors.get_animated_entities"

return function(deltaTime)
  return Thunk("GRAPHICS_UPDATE_FRAME", function(_, getState)
    local state = getState()
    local animators = getAnimated(state, "animator")

    for _, v in ipairs(animators) do
      if v.animator.isPlaying then
        v.animator:update(deltaTime)
        v.sprite = v.animator:getCurrentFrame()
      end
    end
  end)
end