-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.ui.camera.actions.types"

return function(x, y, z)
  return {
    type = types.camera_set_position,
    payload = {
      x = x,
      y = y,
      z = z
    }
  }
end