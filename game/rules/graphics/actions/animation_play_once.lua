-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


return function(animator, animation)
  return {
    type = "ANIMATION_PLAY_ONCE",
    payload = {
      animator = animator,
      animation = animation
    }
  }
end