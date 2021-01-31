-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.ui.camera.actions.types"

return function(width, height)
  return {
    type = types.camera_set_dimensions,
    payload = {
      width = width,
      height = height
    }
  }
end