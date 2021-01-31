-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.settings.actions.types"

return function(name)
  return {
    type = types.settings_toggle_option,
    payload = {
      name = name
    }
  }
end