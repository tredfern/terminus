-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.camera.actions.types"

return function(x, y)
  return {
    type = types.camera_set_position,
    payload = {
      x = x,
      y = y
    }
  }
end