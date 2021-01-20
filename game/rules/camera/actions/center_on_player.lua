-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"
local store = require "moonpie.redux.store"
local set_position = require "game.rules.camera.actions.set_position"

return function(width, height)
  width = width or 0
  height = height or 0
  local c = character.selectors.get_player(store.get_state())
  if c then
    return set_position(
      -width / 2 + c.x,
      -height / 2 + c.y
    )
  end
end