-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"
local store = require "moonpie.redux.store"
local setPosition = require "game.ui.camera.actions.set_position"

return function(width, height)
  width = width or 0
  height = height or 0
  local c = character.selectors.getPlayer(store.getState())
  if c then
    return setPosition(
      math.ceil(-width / 2) + c.x,
      math.ceil(-height / 2) + c.y
    )
  end
end